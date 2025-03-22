require("mini.icons").setup { style = "ascii" }
MiniIcons.mock_nvim_web_devicons()
require("mini.bracketed").setup {}
require("mini.files").setup { use_as_default_explorer = true }
require("mini.diff").setup { view = { style = "sign" } }
vim.keymap.set("n", "cd", MiniFiles.open)

local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    { mode = 'n', keys = '<Leader>G' },
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },
    { mode = 'i', keys = '<C-x>' },
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },
    { mode = 'n', keys = '<C-w>' },
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },
  clues = {
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
    { mode = "n", keys = "<leader>Gc", postkeys = "<leader>G" },
    { mode = "n", keys = "<leader>Gr", postkeys = "<leader>G" },
    { mode = "n", keys = "<leader>Gb", postkeys = "<leader>G" },
    { mode = "n", keys = "<leader>Gh", postkeys = "<leader>G" },
    { mode = "n", keys = "<leader>Gi", postkeys = "<leader>G" },
    { mode = "n", keys = "<leader>Go", postkeys = "<leader>G" },
    { mode = "n", keys = "<leader>Gn", postkeys = "<leader>G" },
    { mode = "n", keys = "<leader>Gu", postkeys = "<leader>G" },
    { mode = "n", keys = "<leader>Gd", postkeys = "<leader>G" },
    { mode = "n", keys = "<leader>GR", postkeys = "<leader>G" },
    { mode = "n", keys = "<leader>Gt", postkeys = "<leader>G" },
    { mode = "n", keys = "<leader>Gv", postkeys = "<leader>G" },
  },
  window = { delay = 100 }
})
