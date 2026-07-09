#!/usr/bin/env python3
import argparse
import html
import json
import os
import socket
import subprocess
import sys
import time


APP_NAMES = {
    "code": "Code",
    "chromium": "Chromium",
    "discord": "Discord",
    "spotify": "Spotify",
    "kitty": "Kitty",
}

WATCH_EVENTS = (
    "activewindow",
    "changegroupactive",
    "closewindow",
    "focusedmon",
    "monitoradded",
    "monitorremoved",
    "movewindow",
    "openwindow",
    "windowtitle",
    "workspace",
)


def hyprctl_json(command):
    result = subprocess.run(
        ["hyprctl", "-j", command],
        check=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.DEVNULL,
        text=True,
    )
    return json.loads(result.stdout)


def app_name(window):
    class_name = window.get("class") or window.get("initialClass") or "window"
    key = class_name.lower()
    if key in APP_NAMES:
        return APP_NAMES[key]
    return class_name[:1].upper() + class_name[1:]


def markup_text(text):
    return html.escape(text, quote=False)


def active_markup(label):
    return (
        '<span foreground="#f5a97f" background="#24273a" '
        f'weight="heavy"> {label} </span>'
    )


def item_position(item):
    windows = item["windows"]
    xs = [window.get("at", [0, 0])[0] for window in windows]
    ys = [window.get("at", [0, 0])[1] for window in windows]
    return min(xs or [0]), min(ys or [0])


def workspace_items(monitor, clients, clients_by_address, active_address):
    workspace = monitor.get("activeWorkspace") or {}
    workspace_id = workspace.get("id")
    workspace_clients = [
        client
        for client in clients
        if (client.get("workspace") or {}).get("id") == workspace_id
    ]

    items = []
    seen_groups = set()

    for client in workspace_clients:
        grouped = client.get("grouped") or []
        if len(grouped) >= 2:
            key = tuple(grouped)
            if key in seen_groups:
                continue
            seen_groups.add(key)
            members = [clients_by_address[address] for address in grouped if address in clients_by_address]
            if members:
                items.append({"kind": "group", "windows": members})
        else:
            items.append({"kind": "window", "windows": [client]})

    items.sort(key=item_position)

    parts = []
    tooltip = [f"{monitor.get('name')} workspace {workspace.get('name', workspace_id)}"]

    for item in items:
        windows = item["windows"]
        labels = []

        for window in windows:
            label = markup_text(app_name(window))
            if window.get("address") == active_address:
                label = active_markup(label)
            labels.append(label)
            title = window.get("title") or app_name(window)
            tooltip.append(f"{app_name(window)}: {title}")

        if item["kind"] == "group":
            parts.append("{" + " / ".join(labels) + "}")
        else:
            parts.append(labels[0])

    text = "  |  ".join(parts) if parts else "empty"
    active_here = any(
        active_address in [window.get("address") for window in item["windows"]]
        for item in items
    )
    return text, tooltip, active_here, bool(parts)


def format_workspaces(monitor_name=None, all_visible=False):
    monitors = hyprctl_json("monitors")
    clients = hyprctl_json("clients")
    active = hyprctl_json("activewindow")
    active_address = active.get("address")
    clients_by_address = {client.get("address"): client for client in clients}

    if all_visible:
        selected_monitors = [monitor for monitor in monitors if not monitor.get("disabled")]
        selected_monitors.sort(key=lambda monitor: (monitor.get("x", 0), monitor.get("y", 0)))
    else:
        selected_monitors = [monitor for monitor in monitors if monitor.get("name") == monitor_name]

    if not selected_monitors:
        return {"text": "", "class": "empty", "tooltip": ""}

    text_parts = []
    tooltip_parts = []
    has_active = False
    has_windows = False

    for monitor in selected_monitors:
        text, tooltip, active_here, has_monitor_windows = workspace_items(
            monitor,
            clients,
            clients_by_address,
            active_address,
        )
        text_parts.append(text)
        tooltip_parts.extend(tooltip)
        tooltip_parts.append("")
        has_active = has_active or active_here
        has_windows = has_windows or has_monitor_windows

    return {
        "text": "    ||    ".join(text_parts),
        "class": "active" if has_active else ("inactive" if has_windows else "empty"),
        "tooltip": "\n".join(tooltip_parts).rstrip(),
    }


def emit(payload):
    print(json.dumps(payload, ensure_ascii=False), flush=True)


def socket_path():
    runtime_dir = os.environ.get("XDG_RUNTIME_DIR")
    signature = os.environ.get("HYPRLAND_INSTANCE_SIGNATURE")
    if not runtime_dir or not signature:
        return None
    return os.path.join(runtime_dir, "hypr", signature, ".socket2.sock")


def watch(monitor_name, all_visible):
    last_payload = None

    def update():
        nonlocal last_payload
        try:
            payload = format_workspaces(monitor_name, all_visible)
        except Exception:
            payload = {"text": "", "class": "empty", "tooltip": ""}
        encoded = json.dumps(payload, ensure_ascii=False)
        if encoded != last_payload:
            print(encoded, flush=True)
            last_payload = encoded

    update()

    path = socket_path()
    if not path:
        while True:
            time.sleep(1)
            update()

    while True:
        try:
            with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as sock:
                sock.connect(path)
                stream = sock.makefile("r", encoding="utf-8", errors="replace")
                for line in stream:
                    if line.startswith(WATCH_EVENTS):
                        update()
        except OSError:
            time.sleep(1)
            update()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--monitor", default="DP-2")
    parser.add_argument("--all-visible", action="store_true")
    args = parser.parse_args()
    watch(args.monitor, args.all_visible)
    return 0


if __name__ == "__main__":
    sys.exit(main())
