local packadd = vim.cmd.packadd
local stub = require("stub")

packadd "nvim-treesitter"
require("configs.tree-sitter")

packadd "plenary.nvim"

stub.command("Neogit", function()
  packadd "neogit"
end)

-- packadd "nightfox.nvim"
-- vim.cmd.colorscheme "terafox"

package.cpath = package.cpath .. ";" .. "/home/cathalo/.nix-profile/lib/lib?.so"

packadd "blink.cmp"
require("blink.cmp").setup {
  fuzzy = {
    prebuilt_binaries = {
      download = false,
    }
  },
  signature = {
    enabled = true,
  },
  completion = {
    documentation = {
      auto_show = true,
    },
  },
  appearance = {
    kind_icons = {
      Text = 'B',
      Method = 'F',
      Function = 'F',
      Constructor = 'F',

      Field = 'A',
      Variable = 'V',
      Property = 'A',

      Class = 'C',
      Interface = 'I',
      Struct = 'C',
      Module = 'M',

      Unit = 'O',
      Value = 'O',
      Enum = 'E',
      EnumMember = 'E',

      Keyword = 'K',
      Constant = 'X',

      Snippet = '~',
      Color = '#',
      File = '.',
      Reference = '*',
      Folder = '/',
      Event = 'V',
      Operator = 'U',
      TypeParameter = 'P',
    }
  }
}

packadd "nvim-lspconfig"
require("lspconfig").lua_ls.setup {}
require("lspconfig").ols.setup {}
require("lspconfig").denols.setup {}
require("lspconfig").svelte.setup {}
require("lspconfig").clangd.setup {}
require("lspconfig").zls.setup {}
require("lspconfig").gopls.setup {}

-- packadd "ctags-lsp.nvim"
-- require("lspconfig").ctags_lsp.setup { filetypes = {} }

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.supports_method('textDocument/rename') then
      vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = args.buf });
    end
    if client.supports_method('textDocument/implementation') then
      vim.keymap.set("n", "gm", vim.lsp.buf.implementation, { buffer = args.buf });
    end
    if client.supports_method('textDocument/definition') then
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf });
    end
    if client.supports_method('textDocument/declaration') then
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = args.buf });
    end
    if client.supports_method('textDocument/typeDefinition') then
      vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { buffer = args.buf });
    end
    if client.supports_method('textDocument/references') then
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = args.buf });
    end
  end,
})

packadd "mini.nvim"
require("mini.icons").setup { style = "ascii" }
MiniIcons.mock_nvim_web_devicons()
require("mini.bracketed").setup {}

-- require("mini.base16").setup {
--   palette = {
--     base00 = "#2b2b2b",
--     base01 = "#323232",
--     base02 = "#323232",
--     base03 = "#606366",
--     base04 = "#a4a3a3",
--     base05 = "#a9b7c6",
--     base06 = "#ffc66d",
--     base07 = "#ffffff",
--     base08 = "#4eade5",
--     base09 = "#689757",
--     base0A = "#bbb529",
--     base0B = "#6a8759",
--     base0C = "#629755",
--     base0D = "#9876aa",
--     base0E = "#cc7832",
--     base0F = "#808080",
--   }
-- }

vim.cmd.colorscheme "minicyan"

vim.cmd.helptags "ALL"

vim.opt.rtp:append("/home/cathalo/Repos/snipe.nvim")
require("configs.snipe")

packadd "telescope.nvim"
require("telescope").setup {
  defaults = require("telescope.themes").get_ivy(),
}
require("configs.telescope")

packadd "snacks.nvim"


packadd "volt"
packadd "typr"
require("typr").setup()
