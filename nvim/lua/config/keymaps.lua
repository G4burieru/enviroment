local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find Words" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview Hunks" })
vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle Current Line Blame" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set("n", "<leader>-", require("oil").toggle_float, { desc = "Toggle Oil" })
vim.keymap.set("n", "<leader><leader>", require("telescope").extensions.recent_files.pick, { desc = "Recent Files" })
vim.keymap.set("n", "<leader>fa", function() builtin.find_files({cwd = '~/'}) end, { desc = "Find Files in Root" })



local wk = require("which-key")
wk.add({
  { "<leader>f",  group = "file" }, -- group
  { "<leader>c",  group = "code" },
  { "<leader>g",  group = "git" },
  { "<leader>a",  group = "Auto-Session" },
  { "<leader>fn", desc = "New File" },
  { "<leader>w",  proxy = "<c-w>",       group = "windows" }, -- proxy to window mappings
  {
    -- Nested mappings are allowed and can be added in any order
    -- Most attributes can be inherited or overridden on any level
    -- There's no limit to the depth of nesting
    mode = { "n", "v" },                        -- NORMAL and VISUAL mode
    { "<leader>q", "<cmd>q<cr>",    desc = "Quit" }, -- no need to specify mode since it's inherited
    { "<leader>w", "<cmd>w<cr>",    desc = "Write" },
    { "<leader>l", "<cmd>Lazy<cr>", desc = "Lazy" },
    { "<leader>W", "<cmd>wa<cr>",   desc = "Write All" },
    { "<leader>Q", "<cmd>qa<cr>",   desc = "Quit All" },
  },
})
