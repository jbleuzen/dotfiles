-- {{{ Mason require
local status, mason = pcall(require, "mason")
if not status then
  vim.notify("Problem with mason")
  return
end
-- }}}

-- {{{ Mason LSPConfig require
local statusMasonLspConfig, masonLspConfig = pcall(require, "mason-lspconfig")
if not statusMasonLspConfig then
  vim.notify("Problem with mason-lspconfig")
  return
end
-- }}}

-- {{{  LSPConfig require
-- lspconfig must be loaded after Mason
local statusLspConfig, lspconfig = pcall(require, "lspconfig")
if not statusLspConfig then
  vim.notify("Problem with lspconfig")
  return
end
-- }}}

mason.setup({
    ui = {
    -- Whether to automatically check for new versions when opening the :Mason window.
    check_outdated_packages_on_open = true,
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = "single",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

masonLspConfig.setup({
  -- A list of servers to automatically install if they're not already installed
  ensure_installed = {
    "bashls",
    "cssls",
    "eslint",
    "graphql",
    "html",
    "jsonls",
    "sumneko_lua",
    "tailwindcss",
    "tsserver",
    "vuels",
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


-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>k', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<leader>l', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

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
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- capabilities.textDocument.foldingRange = {
--   dynamicRegistration = false,
--   lineFoldingOnly = true
-- }

-- {{{ Typescript
lspconfig.tsserver.setup({
  on_attach = on_attach
})
-- }}}

-- {{{ Eslint
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
-- }}}

-- {{{ Vue.js
-- lspconfig.vuels.setup({
--   root_dir= lspconfig.util.root_pattern("package.json", "vue.config.js"),
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     codeActionOnSave = {
--       enable = true,
--       mode = "all"
--     },
--   },
--   init_options = {
--     config = {
--       css = {},
--       emmet = {},
--       html = {
--         suggest = {}
--       },
--       javascript = {
--         format = {}
--       },
--       stylusSupremacy = {},
--       vetur = {
--         completion = {
--           autoImport = true,
--           tagCasing = "kebab",
--           useScaffoldSnippets = false
--         },
--         dev= {logLevel = "DEBUG"},
--         format = {
--           options = {
--             tabsize = 12
--           },
--           defaultFormatter = {
--             html= "eslint",
--             js = "eslint",
--             sass= "sass-formatter",
--             ts = "eslint"
--           },
--           defaultFormatterOptions = {},
--           scriptInitialIndent = false,
--           styleInitialIndent = false
--         },
--         useWorkspaceDependencies = true,
--         validation = {
--           script = true,
--           style = true,
--           template = true
--         }
--       }
--     }
--   }
-- })
-- }}}

-- {{{ TailwindCSS
lspconfig.tailwindcss.setup{}
-- }}}
