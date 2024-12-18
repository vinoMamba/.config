return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
    'williamboman/mason-lspconfig.nvim',
    -- Allows extra capabilities provided by nvim-cmp
    -- 'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    vim.fn.sign_define('DiagnosticSignError', { texthl = 'DiagnosticSignError', text = '❌', numhl = "" })
    vim.fn.sign_define('DiagnosticSignWarn', { texthl = 'DiagnosticSignWarn', text = '⚠️', numhl = "" })
    vim.fn.sign_define('DiagnosticSignHint', { texthl = 'DiagnosticSignHint', text = '⛳', numhl = "" })
    vim.fn.sign_define('DiagnosticSignInfo', { texthl = 'DiagnosticSignInfo', text = '💬', numhl = "" })

    vim.diagnostic.config({
      virtual_text = true,
      severity_sort = true,
      signs = true,
      update_in_insert = false,
      underline = false,
      float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end
        local builtin = require('telescope.builtin')

        map("<leader>w", vim.diagnostic.open_float, "[F]loat")

        map("<leader>k", vim.lsp.buf.hover, "[H]over")
        map('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
        map('gr', builtin.lsp_references, '[G]oto [R]eferences')
        map('gi', builtin.lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>D', builtin.lsp_type_definitions, 'Type [D]efinition')
        map('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
        map('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      end
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- NOTE: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssls
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    -- INFO: broadcast that to the servers

    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    require('mason').setup()

    local servers = {
      cssls = {},
      html = {},
      jsonls = {
        settings = {
          format = { enable = true },
        }
      },
      lua_ls = {},
      sqlls = {},
      ts_ls = {},
      eslint = {},
      gopls = {},
      tailwindcss = {}
    }

    local ensure_installed = vim.tbl_keys(servers or {})

    require("mason-lspconfig").setup {
      ensure_installed = ensure_installed,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      }
    }
  end
}
