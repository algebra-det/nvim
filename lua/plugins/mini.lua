return {
  { "nvim-mini/mini.surround", version = "*" },
  {
    "nvim-mini/mini.files",
    version = "*",
    opts = {
      windows = {
        preview = false,
        -- Width of focused window
        width_focus = 33,
        -- Width of non-focused window
        width_nofocus = 33,
        -- Width of preview window
        width_preview = 33,
      },
    },
  },
}
