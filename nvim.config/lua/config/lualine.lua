-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require 'lualine'

-- Color table for highlights
local colors = require('monokai').soda

local theme = {
  normal = {
    a = {bg = "#AFD700", fg = "#005F00", gui = "bold"},
    b = {bg = "#585858", fg = "#BCBCBC"},
    c = {bg = "#303030", fg = "#9E9E9E"},
    z = {bg = "#D0D0D0", fg = "#626262"}
  },
  insert = {
    a = {bg = colors.white, fg = "#005F5F", gui = 'bold'},
    b = {bg = "#0087AF", fg = "white"},
    c = {bg = "#005A87", fg = "#87D7FF"},
    z = {bg = "#87D7FF", fg = "#005F5F"}
  },
  visual = {
    a = {bg = "#FF8700", fg = "#870000", gui = 'bold'},
    z = {bg = "#D0D0D0", fg = "#626262"}
  },
  replace = {
    a = {bg = "#D70000", fg = colors.white, gui = 'bold'},
    z = {bg = "#D0D0D0", fg = "#626262"}
  },
  command = {
    a = {bg = colors.purple, fg = "#333333", gui = 'bold'},
    z = {bg = "#D0D0D0", fg = "#626262"}
  },
  inactive = {
    a = {bg = "#303030", fg = '#9E9E9E'},
  }
}

-- Config
local config = {
  options = {
  -- Disable sections and component separators
    globalstatus = true, -- Display only one status bar for all panes
    section_separators = "",
    component_separators = "",
    theme = theme,
  },
  extensions = {'quickfix'},
  sections = {
    lualine_a = {
      {
        'mode',
        fmt = function (mode)
          return mode:sub(1,1) -- Just return the first letter of the mode
        end,
        padding = { left = 1, right = 1 }, -- We don't need space before this
       },
     },
    lualine_b = {
       {
         'branch',
         icon = '',
      }
    },
--      {
--        'filename',
--        color = { fg = colors.white, bg = colors.grey },
--        file_status = true,      -- Displays file status (readonly status, modified status)
--        newfile_status = false,   -- Display new file status (new file means no write after created)
--        path = 1,                -- 0: Just the filename 1: Relative path 2: Absolute path 3: Absolute path, with tilde as the home directory
--        shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
--        -- for other components. (terrible name, any suggestions?)
--        symbols = {
--          modified = '●',      -- Text to show when the file is modified.
--          readonly = '',      -- Text to show when the file is non-modifiable or readonly.
--          unnamed = '[No Name]', -- Text to show for unnamed buffers.
--          newfile = '[New]',     -- Text to show for new created file before first writting
--        }
--      }
    lualine_c = {
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', hint = ' ', info = ' ' },
        diagnostics_color = {
        },
      }
    },
    lualine_x = {
      {
        'encoding',
        separator = '|',
      },
      {
        'fileformat',
        separator = '|',
      },
      {
        'filetype',
        separator = '|',
      },
      {
        function()
          local msg = 'NO LSP'
          local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        separator = '|',
    },
 -- {
 --     'diff',
 --     colored = true, -- Displays a colored diff status if set to true
 --     diff_color = {
 --       -- Same color values as the general color option can be used here.
 --       added    = 'DiffAdd',    -- Changes the diff's added color
 --       modified = 'DiffChange', -- Changes the diff's modified color
 --       removed  = 'DiffDelete', -- Changes the diff's removed color you
 --     },
 --     symbols = {added = '+', modified = '~', removed = '-'}, -- Changes the symbols used by the diff.
 --     source = nil, -- A function that works as a data source for diff.
 --                   -- It must return a table as such:
 --                   --   { added = add_count, modified = modified_count, removed = removed_count }
 --                   -- or nil on failure. count <= 0 won't be displayed.
 --   }
  },
    lualine_y = {
      'progress'
    },
    lualine_z = {
      {
        'location',
      },
    }
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_v = {},
    lualine_c = {{
      'filename',
       file_status = false,      -- Displays file status (readonly status, modified status)
       newfile_status = false,   -- Display new file status (new file means no write after created)
       path = 1,                -- 0: Just the filename 1: Relative path 2: Absolute path 3: Absolute path, with tilde as the home directory
  },
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', hint = ' ', info = ' ' },
        diagnostics_color = {
        },
      }},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
}

-- Now don't forget to initialize lualine
lualine.setup(config)
