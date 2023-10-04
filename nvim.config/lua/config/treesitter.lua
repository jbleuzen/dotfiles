local ts = require("nvim-treesitter.configs")

ts.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  auto_install = true,
  ensure_installed = {
    "tsx",
    "toml",
    "fish",
    "php",
    "javascript",
    "json",
    "jsonc",
    "markdown",
    "markdown_inline",
    "yaml",
    "swift",
    "css",
    "html",
    "lua",
    "vim",
    "vue",
  },
  autotag = {
    enable = false,
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
