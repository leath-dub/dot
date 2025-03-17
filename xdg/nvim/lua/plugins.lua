local packadd = vim.cmd.packadd
local stub = require("stub")

packadd "nvim-treesitter"
require("configs.tree-sitter")

packadd "plenary.nvim"

stub.command("Neogit", function()
  packadd "neogit"
end)

package.cpath = package.cpath .. ";" .. "/home/cathalo/.nix-profile/lib/lib?.so"

packadd "blink.cmp"
require("blink.cmp").setup {
  fuzzy = {
    implementation = 'rust',
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
require("lspconfig").pylsp.setup {}
require("lspconfig").rust_analyzer.setup {}
require("lspconfig").jdtls.setup {}
require('lspconfig').harper_ls.setup {}

-- packadd "ctags-lsp.nvim"
-- require("lspconfig").ctags_lsp.setup { filetypes = {} }

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
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
require("configs.mini")

vim.cmd.helptags "ALL"

packadd "snipe.nvim"
require("configs.snipe")

packadd "snacks.nvim"
require("configs.snacks")

vim.cmd.colorscheme "habamax"
