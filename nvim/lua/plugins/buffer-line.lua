return {
  {
    "akinsho/bufferline.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          numbers = "none",
          close_command = "bdelete! %d",
          right_mouse_command = "bdelete! %d",
          left_mouse_command = "buffer %d",
          middle_mouse_command = nil,
          indicator_icon = "▎",
          buffer_close_icon = "",
          modified_icon = "●",
          close_icon = "",
          left_trunc_marker = "",
          right_trunc_marker = "",
          max_name_length = 18,
          max_prefix_length = 15,
          tab_size = 18,
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          diagnostics_indicator = function(count)
            return "(" .. count .. ")"
          end,
          custom_filter = function(buf_number)
            if vim.bo[buf_number].filetype ~= "neo-tree" then
              return true
            end
            if vim.fn.bufname(buf_number) ~= "plugin://some_plugin" then
              return true
            end
            if vim.fn.getcwd() == "/path/to/your/work/repo" and vim.bo[buf_number].filetype ~= "wiki" then
              return true
            end
          end,
          offsets = { { filetype = "neo-tree", text = "File Explorer", text_align = "left" } },
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          show_tab_indicators = true,
          persist_buffer_sort = true,
          separator_style = "slant",
          enforce_regular_tabs = false,
          always_show_bufferline = true,
          sort_by = "id",
        },
      })

      -- Keybindings for bufferline
      vim.api.nvim_set_keymap(
        "n",
        "<leader><Tab>",
        "<cmd>BufferLineCycleNext<CR>",
        { noremap = true, silent = true, desc = "Next Buffer" }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader><S-Tab>",
        "<cmd>BufferLineCyclePrev<CR>",
        { noremap = true, silent = true, desc = "Previous Buffer" }
      )
    end,
  },
}
