require("nvim-treesitter.configs").setup {
  ensure_installed = { "rust", "zig", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "html" },
  sync_install = false,
  auto_install = true,
  highlight = { enable = true },
}

vim.filetype.add({
  extension = {
    c3 = "c3",
    c3i = "c3",
    c3t = "c3",
  },
})

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

parser_config.c3 = {
  install_info = {
    url = "https://github.com/c3lang/tree-sitter-c3",
    files = { "src/parser.c", "src/scanner.c" },
    branch = "main",
  },
}
