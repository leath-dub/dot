require("mini.icons").setup { style = "ascii" }
MiniIcons.mock_nvim_web_devicons()
require("mini.bracketed").setup {}
require("mini.files").setup { use_as_default_explorer = true }
require("mini.diff").setup { view = { style = "sign" } }
vim.keymap.set("n", "cd", MiniFiles.open)
