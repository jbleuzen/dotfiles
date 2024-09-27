return {
  -- Colorscheme
  'tanvirtin/monokai.nvim',
  priority = 1000,
  config = function ()
    local monokai = require('monokai')
    local palette = monokai.soda

    monokai.setup {
      palette = {
        base2 = "#000000"
      },
      custom_hlgroups = {
        Normal = {
          bg = "#000000"
        },
        NormalNC = {
          bg = "#1C1C1C",
        },
        CursorLineNr = {
          bg = "#303030",
          fg = "#FF8700"
        },
        LineNr = {
          bg = "#202020",
          fg = "#666666",
        },
        SignColumn = {
          bg = "#202020",
          fg = "#666666",
        },
        CursorLineSign = {
          bg = "#303030",
          fg = "#BCBCBC",
        },
        -- lsp
        DiagnosticSignInfo = {
          bg = "#202020",
        },
        DiagnosticSignHint = {
          bg = "#202020",
        },
        DiagnosticSignWarn = {
          bg = "#202020",
        },
        DiagnosticSignError = {
          bg = "#202020",
        },
        -- nvim-tree
        NvimTreeNormal = {
          bg = "#000000"
        },
        NvimTreeNormalNC = {
          bg = "#1C1C1C"
        },
        NvimTreeIndentMarker = {
          fg= "#333333"
        },
        NvimTreeRootArrowOpen = {
          fg = palette.base8,
          bg = "#00FF00"
        },
        NvimTreeRootFolder = {
          fg = palette.base8,
          bg = "#00FF00"
        },
        NvimTreeFolderName = {
          fg = palette.green,
        },
        NvimTreeFolderIcon = {
          fg = palette.green,
        },
        NvimTreeEndOfBuffer = {
          fg= "#000000",
          bg = "#000000"
        },
        NvimTreeOpenedFolderName = {
          fg = palette.green,
        },
        NvimTreeSpecialFile = {
          fg = palette.purple
        },
        NvimTreeSymlink = {
          fg = palette.aqua,
        },
        NvimTreeGitDirty = {
          fg=palette.green,
          bg="#000000"
        },
        -- FZF
        FZFLuaBorder = {
          fg = "#666666"
        },
        -- Trouble 
        TroubleNormalNC = {
          bg = "#1C1C1C"
        },
        TroubleTextError = {
          fg = "#D75F87"
        },
        TroubleTextWarning = {
          fg = "#D7D787"
        },
        TroubleTextHint = {
          fg = "#5FD7FF"
        },
        TroubleFoldIcon = {
          fg = "#87D700"
        },
        TroubleFile = {
          fg = "#87D700"
        }
      }
    }

    local cmd = vim.cmd

    -- Change the background color of inactive pane/window
    cmd [[
    autocmd FocusGained * hi Normal guibg=#000000 | hi NvimTreeNormal guibg=#000000 | hi TroubleNormal guibg=#000000
    autocmd FocusLost * hi Normal guibg=#1C1C1C | hi NvimTreeNormal guibg=#1C1C1C | hi NvimTreeEndOfBuffer guifg=#1C1C1C guibg=#1C1C1C | hi TroubleNormal guibg=#1C1C1C
    ]]

    vim.api.nvim_create_autocmd({ "BufEnter" }, {
      pattern = "*",
      callback = function(opts)
        if vim.bo[opts.buf].filetype == "NvimTree" or vim.bo[opts.buf].filetype == "trouble" then
          cmd[[
          hi NvimTreeEndOfBuffer guifg=#000000 guibg=#000000
          hi NvimTreeGitDirty guibg=#000000
          hi NvimTreeSignColumn guifg=#000000 guibg=#000000
          hi NvimTreeGitNew guibg=#000000
          hi NvimTreeGitAdded guibg=#000000
          hi NvimTreeGitDeleted guibg=#000000
          hi NvimTreeGitMerge guibg=#000000
          hi NvimTreeGitIgnored guibg=#000000
          hi NvimTreeGitStaged guibg=#000000
          hi TroubleNormal guibg=#000000 
          ]]
        end
      end,
      group = nt_au_group,
    })

    vim.api.nvim_create_autocmd({ "BufLeave" }, {
      pattern = "*",
      callback = function(opts)
        local a =  vim.bo[opts.buf].filetype
        print(a)
        if vim.bo[opts.buf].filetype == "NvimTree" or vim.bo[opts.buf].filetype == "trouble" then
          cmd[[
          hi NvimTreeEndOfBuffer guifg=#1C1C1C guibg=#1C1C1C
          hi NvimTreeGitDirty guibg=#1C1C1C
          hi NvimTreeSignColumn guifg=#1C1C1C guibg=#1C1C1C
          hi NvimTreeGitNew guibg=#1C1C1C
          hi NvimTreeGitAdded guibg=#1C1C1C
          hi NvimTreeGitDeleted guibg=#1C1C1C
          hi NvimTreeGitMerge guibg=#1C1C1C
          hi NvimTreeGitIgnored guibg=#1C1C1C
          hi NvimTreeGitStaged guibg=#1C1C1C
          hi TroubleNormal guibg=#1C1C1C
          ]]
        end
      end,
      group = nt_au_group,
    })
  end
}
