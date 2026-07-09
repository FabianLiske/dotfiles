hl.window_rule({
  name = "intellij-no-initial-focus",
  match = {
    class = "^(jetbrains-)(.*)",
    float = true,
  },
  no_initial_focus = true,
})
