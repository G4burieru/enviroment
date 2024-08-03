return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set("n", "<leader>e", ":Neotree filesystem reveal left<CR>", {desc = "NeoTree Explorer", silent = true})
		vim.keymap.set("n", "<leader>E", ":Neotree buffers reveal float<CR>", {desc = "Neotree buffers reveal", silent = true})
	end,
}
