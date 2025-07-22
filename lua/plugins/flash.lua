return {
  "folke/flash.nvim",
  enabled = true,
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump({
          search = {
            mode = function(str)
              return "\\<" .. str
            end,
          },
        })
      end,
      desc = "Flash",
    },
    {
      "S",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
    -- {
    --   "r",
    --   mode = { "n", "x", "o" },
    --   function()
    --     require("flash").remote()
    --   end,
    --   desc = "Flash Remote",
    -- },
    {
      "<c-s>",
      mode = { "n", "x", "o" },
      function()
        require("flash").toggle()
      end,
      desc = "Toggle Flash",
    },
  },
}
