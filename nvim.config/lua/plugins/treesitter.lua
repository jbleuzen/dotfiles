return {
  "nvim-treesitter/nvim-treesitter",
  version = "0.9.2", -- https://github.com/nvim-treesitter/nvim-treesitter/issues/2293
  config = function( )
    require("nvim-treesitter.configs").setup {
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
        "bash",
        "comment",
        "css",
        "dockerfile",
        "fish",
        "html",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "tsx",
        "php",
        "tsx",
        "toml",
        "vim",
        "vue",
        "yaml",
      },
      autotag = {
        enable = false,
      },
    }

    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
  end
}
