return {
  {
    "gbprod/yanky.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    config = function()
      require("telescope").load_extension("yank_history")
      vim.keymap.set("n", "<leader>p", ":Telescope yank_history<CR>", { desc = "Open Yank History" })
      require("yanky").setup({
        ring = {
          history_length = 100,
          storage = "shada",
          sync_with_numbered_registers = true,
          cancel_event = "update",
          ignore_registers = { "_" },
          update_register_on_cycle = false,
        },
        system_clipboard = {
          sync_with_ring = true,
        },
      })
    end,
  },
}
