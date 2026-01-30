return {
   reload_on_bufenter = true,
   sync_root_with_cwd = false,
   respect_buf_cwd = false,
   auto_reload_on_write = true,
   hijack_directories = {
      enable = false,
      auto_open = true,
   },
   actions = {
      open_file = {
         quit_on_open = false,
         resize_window = false,
         window_picker = {
            enable = false,
         },
      },
   },
   update_focused_file = {
      enable = false,
   },
   git = {
      ignore = false,
   },
   view = {
      signcolumn = "no",
      centralize_selection = true,
      adaptive_size = false,
      side = "right",
      preserve_window_proportions = true,
      width = 25,
      float = {
         enable = true,
         quit_on_focus_loss = false,
         open_win_config = function()
            local screen_height = vim.o.lines - 4

            return {
               row = 0,
               width = 25,
               border = "rounded",
               relative = "editor",
               col = vim.o.columns,
               height = screen_height,
            }
         end,
      },
   },
   renderer = {
      highlight_git = true,
      icons = {
         show = {
            git = true,
         },
      },
   },
}
