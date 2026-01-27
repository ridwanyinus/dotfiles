# -----------------------------------------------------
# AUTOSTART
# -----------------------------------------------------

# -----------------------------------------------------
# Fastfetch
# -----------------------------------------------------
# Only run in interactive shells with a real terminal (not fzf subshells)
if status is-interactive; and isatty stdout
    fastfetch
end