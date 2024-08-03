local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find Words" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {desc = "Preview Hunks"})
vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {desc = "Toggle Current Line Blame"})

-- Map a shortcut to open the picker.
vim.api.nvim_set_keymap(
	"n",
	"<Leader><Leader>",
	[[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]],
	{ noremap = true, silent = true, desc = "Recent Files" }
)

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x> <c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See ´:help vim.lsp.*` for documentation on any of the below functions
		vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, { desc = "Hover" })
		vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "Goto Definition" })
		vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, { desc = "Goto References" })
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
		vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format Code" })
	end,
})

local wk = require("which-key")
wk.add({
	{ "<leader>f", group = "file" }, -- group
	{ "<leader>c", group = "code" },
	{ "<leader>g", group = "git" },
	{ "<leader>fn", desc = "New File" },
	{ "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
	{
		-- Nested mappings are allowed and can be added in any order
		-- Most attributes can be inherited or overridden on any level
		-- There's no limit to the depth of nesting
		mode = { "n", "v" }, -- NORMAL and VISUAL mode
		{ "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
		{ "<leader>w", "<cmd>w<cr>", desc = "Write" },
		{ "<leader>l", "<cmd>Lazy<cr>", desc = "Lazy" },
		{ "<leader>W", "<cmd>wa<cr>", desc = "Write All" },
		{ "<leader>Q", "<cmd>qa<cr>", desc = "Quit All" },
	},
})
