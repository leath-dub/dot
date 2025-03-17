require("snacks").setup {
  picker = {
    ui_select = false,
    layout = {
      preset = "ivy",
      layout = { position = "bottom" }
    }
  }
}

vim.keymap.set("n", "<leader>f", Snacks.picker.files)
vim.keymap.set("n", "<leader>g", Snacks.picker.grep)
vim.keymap.set("n", "<leader>.", function() Snacks.picker() end)
vim.keymap.set("n", "<leader>s", Snacks.picker.lsp_symbols)
