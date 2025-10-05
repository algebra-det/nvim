if true then
  return {}
else
  return {
    {
      "ellisonleao/gruvbox.nvim",
      priority = 1000,
      config = true,
      opts = {
        theme = "gruvbox_dark",
      },
    },
  }
end
