return {
	{
		"rmagatti/auto-session",
		lazy = false,
		dependencies = {
			"nvim-telescope/telescope.nvim", -- Only needed if you want to use sesssion lens
		},
		config = function()
			require("auto-session").setup({
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
				auto_session_enabled = true,
				auto_restore_enabled = false,
			})
      vim.keymap.set("n", "<leader>as", require("auto-session.session-lens").search_session, {
        noremap = true, desc = "Session History"
      })
      vim.keymap.set("n", "<leader>ar", ":SessionRestore<CR><CR>", {desc = "Restore Last Session", noremap = true})
		end,
	},
}
