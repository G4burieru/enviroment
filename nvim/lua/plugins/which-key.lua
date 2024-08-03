return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      { "<leader>f",  group = "file" }, -- group
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
      {
        "<leader>fb",
        function()
          print("hello")
        end,
        desc = "Foobar",
      },
      { "<leader>fn", desc = "New File" },
      { "<leader>f1", hidden = true },                  -- hide this keymap
      { "<leader>w",  proxy = "<c-w>",  group = "windows" }, -- proxy to window mappings
      {
        "<leader>b",
        group = "buffers",
        expand = function()
          return require("which-key.extras").expand.buf()
        end,
      },
    },
  },
}
