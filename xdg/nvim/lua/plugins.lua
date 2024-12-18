local packadd = vim.cmd.packadd
local stub = require("stub")

packadd "nvim-treesitter"
require("configs.tree-sitter")

stub.command("Neogit", function()
  packadd "plenary.nvim"
  packadd "neogit"
end)

packadd "nightfox.nvim"
vim.cmd.colorscheme "terafox"

packadd "blink.cmp"
package.cpath = package.cpath .. ";" .. "/home/cathalo/.nix-profile/lib/lib?.so"

require("blink-cmp").setup {
  fuzzy = {
    prebuilt_binaries = {
      download = false,
    }
  },
  sources = {
    default = {"lsp", "path", "snippets", "buffer"},
  }
}

packadd "nvim-lspconfig"
require("lspconfig").lua_ls.setup {}
