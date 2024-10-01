return {
  -- Colorscheme
  'tanvirtin/monokai.nvim',
  priority = 1000,
  config = function ()
    local monokai = require('monokai')
    local palette = monokai.soda

    --[[
     palette = {
        name = 'monokai',
        base1 = '#272a30',
        base2 = '#26292C',
        base3 = '#2E323C',
        base4 = '#333842',
        base5 = '#4d5154',
        base6 = '#9ca0a4',
        base7 = '#b1b1b1',
        border = '#a1b5b1',
        brown = '#504945',
        white = '#f8f8f0',
        grey = '#8F908A',
        black = '#000000',
        pink = '#f92672',
        green = '#a6e22e',
        aqua = '#66d9ef',
        yellow = '#e6db74',
        orange = '#fd971f',
        purple = '#ae81ff',
        red = '#e95678',
        diff_add = '#3d5213',
        diff_remove = '#4a0f23',
        diff_change = '#27406b',
        diff_text = '#23324d',
    },
    --]]

    monokai.setup {
      palette = {
        base2 = "#000000",
      },
      custom_hlgroups = {
        Normal = {
          bg = palette.black
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
          bg = palette.black
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
          bg = palette.green
        },
        NvimTreeRootFolder = {
          fg = palette.base8,
          bg = palette.green
        },
        NvimTreeFolderName = {
          fg = palette.green,
        },
        NvimTreeFolderIcon = {
          fg = palette.green,
        },
        NvimTreeEndOfBuffer = {
          fg= palette.black,
          bg = palette.black
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
          bg= palette.black
        },
        -- FZF
        FZFLuaBorder = {
          fg = "#666666"
        },
        -- Trouble 
        TroubleNormalNC = {
          bg = "#1C1C1C"
        },
        TroubleFilename = {
          fg = palette.green
        },
        TroubleTextError = {
          fg = palette.red
        },
        TroubleTextWarning = {
          fg = palette.yellow
        },
        TroubleTextHint = {
          fg = palette.aqua
        },
        TroubleFoldIcon = {
          fg = palette.green
        },
        TroubleFile = {
          fg = palette.green
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
    })
  end
}
