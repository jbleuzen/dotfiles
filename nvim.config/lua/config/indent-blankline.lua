 vim.cmd [[highlight IndentBlanklineIndent1 guibg=#111111 gui=nocombine]]

local highlight = {
    "IndentBlanklineIndent1",
    "Whitespace",
}

require("ibl").setup { 
  indent = { highlight = highlight, char = "" },
  whitespace = {
    highlight = highlight,
    remove_blankline_trail = false,
  },
  scope = { enabled = true },
}
