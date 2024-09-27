return {
  "williamboman/mason.nvim",
  dependencies= {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    local mason = require('mason')

    mason.setup({
      ui = {
        -- Whether to automatically check for new versions when opening the :Mason window.
        check_outdated_packages_on_open = true,
        -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
        border = "single",
        icons = {
          package_installed = "✓",
          package_pending = "→",
          package_uninstalled = "✕"
        }
      }
    })

    require("mason-lspconfig").setup({
      -- A list of servers to automatically install if they're not already installed
      ensure_installed = {
        "bashls",
        "cssls",
        "eslint",
        "graphql",
        "html",
        "jsonls",
        "lua_ls",
        "tailwindcss",
        "ts_ls",
        -- "vetur-vls",
      },

      -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
      -- This setting has no relation with the `ensure_installed` setting.
      -- Can either be:
      --   - false: Servers are not automatically installed.
      --   - true: All servers set up via lspconfig are automatically installed.
      --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
      --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
      automatic_installation = true,
    })

    local lspconfig = require('lspconfig')
    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      client.server_capabilities.document_formatting = true
      if client.server_capabilities.document_formatting then
        local au_lsp = vim.api.nvim_create_augroup("eslint_lsp", { clear = true })
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = "*",
          callback = function()
            vim.lsp.buf.format()
          end,
          group = au_lsp,
        })
      end
      client.server_capabilities.documentFormattingProvider = true
      local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

      buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

      -- Mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local bufopts = { noremap=true, silent=true, buffer=bufnr }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
      vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
      vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
      vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, bufopts)
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
      vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, bufopts)
      vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    lspconfig.ts_ls.setup({
      on_attach = on_attach
    })

    lspconfig.jsonls.setup({
      capabilities = capabilities
    })

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
        },
      },
    })

    -- Need to install neovim npm package to make it work
    -- npm install -g neovim
    lspconfig.eslint.setup({
      root_dir = lspconfig.util.root_pattern( 
        '.eslintrc', 
        '.eslintrc.js', 
        '.eslintrc.cjs', 
        '.eslintrc.yaml', 
        '.eslintrc.yml', 
        '.eslintrc.json', 
        'package.json' 
      ),
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        debug=true,
        codeAction = {
          disableRuleComment = {
            enable = true,
            location = "separateLine"
          },
          showDocumentation = {
            enable = true
          }
        },
        codeActionOnSave = {
          enable = true,
          mode = "all"
        },
        experimental = {
          useFlatConfig = false
        },
        format = true,
        nodePath = "",
        onIgnoredFiles = "off",
        packageManager = "npm",
        problems = {
          shortenToSingleLine = false
        },
        quiet = false,
        rulesCustomizations = {},
        run = "onType",
        useESLintClass = false,
        validate = "on",
        workingDirectory = {
          mode = "location"
        }
      }
    })

    lspconfig.vuels.setup({})

    lspconfig.tailwindcss.setup({})


    -- Automatically update diagnostics
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      update_in_insert = true,
      virtual_text = { spacing = 2, prefix = "●" },
      severity_sort = true,
    })

    local signs = { Error = "E", Warn = "W", Info = "i", Hint = "?" }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#]]
    vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#ffffff]]

    -- LSP settings
    local on_attach = function(client)
      vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"})
      vim.lsp.handlers["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = "single"})
    end

    -- Keymaps
    local keymap = vim.keymap
    local opts = { silent = true, noremap = true}
    keymap.set('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', opts)
    keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    keymap.set('n', 'gi', ':FzfLua lsp_implementations<CR>', opts)
    keymap.set('n', 'K', ':lua vim.lsp.buf.hover()<CR>', opts)
    keymap.set('n', '<Leader>s', ':lua vim.lsp.buf.rename()<CR>', opts)
    keymap.set('n', 'gr', ':lua require"fzf-lua".lsp_references({ winopts = { height=0.4, width=1, row=1 } })<CR>', opts)
  end
}

