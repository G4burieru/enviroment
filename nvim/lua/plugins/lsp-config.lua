return {
  {
    {
      "VonHeikemen/lsp-zero.nvim",
      branch = "v4.x",
      lazy = true,
      config = false,
    },
    {
      "williamboman/mason.nvim",
      lazy = false,
      config = true,
    },

    -- Autocompletion
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
        { "L3MON4D3/LuaSnip" },
      },
      config = function()
        local cmp = require("cmp")

        cmp.setup({
          sources = {
            { name = "nvim_lsp" },
          },
          mapping = cmp.mapping.preset.insert({
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-u>"] = cmp.mapping.scroll_docs(-4),
            ["<C-d>"] = cmp.mapping.scroll_docs(4),
          }),
          snippet = {
            expand = function(args)
              vim.snippet.expand(args.body)
            end,
          },
        })
      end,
    },

    -- LSP
    {
      "neovim/nvim-lspconfig",
      cmd = { "LspInfo", "LspInstall", "LspStart" },
      event = { "BufReadPre", "BufNewFile" },
      dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
      },
      config = function()
        local lsp_zero = require("lsp-zero")

        -- lsp_attach is where you enable features that only work
        -- if there is a language server active in the file
        local lsp_attach = function()
          vim.keymap.set("n", "<leader>cK", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "Show Hover" })
          vim.keymap.set(
            "n",
            "<leader>cd",
            "<cmd>lua vim.lsp.buf.definition()<cr>",
            { desc = "Go to Definition" }
          )
          vim.keymap.set(
            "n",
            "<leader>cD",
            "<cmd>lua vim.lsp.buf.declaration()<cr>",
            { desc = "Go to Declaration" }
          )
          vim.keymap.set(
            "n",
            "<leader>ci",
            "<cmd>lua vim.lsp.buf.implementation()<cr>",
            { desc = "Go to Implementation" }
          )
          vim.keymap.set(
            "n",
            "<leader>co",
            "<cmd>lua vim.lsp.buf.type_definition()<cr>",
            { desc = "Go to Type Definition" }
          )
          vim.keymap.set(
            "n",
            "<leader>cr",
            "<cmd>lua vim.lsp.buf.references()<cr>",
            { desc = "Go to References" }
          )
          vim.keymap.set(
            "n",
            "<leader>cs",
            "<cmd>lua vim.lsp.buf.signature_help()<cr>",
            { desc = "Show Signature Help" }
          )
          vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename" })
          vim.keymap.set(
            { "n", "x" },
            "<leader>cf",
            "<cmd>lua vim.lsp.buf.format({async = true})<cr>",
            { desc = "Format" }
          )
          vim.keymap.set(
            "n",
            "<leader>ca",
            "<cmd>lua vim.lsp.buf.code_action()<cr>",
            { desc = "Code Action" }
          )
        end

        lsp_zero.extend_lspconfig({
          sign_text = true,
          lsp_attach = lsp_attach,
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })

        require("mason-lspconfig").setup({
          ensure_installed = {},
          handlers = {
            -- this first function is the "default handler"
            -- it applies to every language server without a "custom handler"
            function(server_name)
              require("lspconfig")[server_name].setup({})
            end,
          },
        })
      end,
    },
  },
}
