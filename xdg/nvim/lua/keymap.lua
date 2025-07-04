local keymap = vim.keymap

keymap.set("n", "ga", "<c-^>", { desc = "Go to previously accessed buffer", noremap = true })
keymap.set({ "n", "v" }, "<leader>y", '"+y', { noremap = true })
keymap.set({ "n", "v" }, "<leader>Y", '"+yg_', { noremap = true }) keymap.set({ "n", "v" }, "<leader>p", '"+p', { noremap = true })
keymap.set({ "n", "v" }, "<leader>P", '"+P', { noremap = true })

-- Press yc to copy unamed(") register to system(*) register
local function regmove(r1, r2) vim.fn.setreg(r1, vim.fn.getreg(r2)) end
keymap.set("n", "yc", function() regmove('+', '"') end, { noremap = true }) -- move contents of anon register to system cliboard register

keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { noremap = true })

keymap.set('n', 'gK', function()
  vim.diagnostic.config({ virtual_lines = true })
  keymap.set("n", "<esc>", function()
    keymap.del("n", "<esc>")
    vim.diagnostic.config({ virtual_lines = false })
  end)
end, { desc = 'Toggle diagnostic virtual_lines' })

keymap.set("n", "[d", function()
  vim.diagnostic.goto_prev()
  vim.diagnostic.open_float()
end, { desc = "Goto previous diagnostic" })

keymap.set("n", "]d", function()
  vim.diagnostic.goto_next()
  vim.diagnostic.open_float()
end, { desc = "Goto next diagnostic" })

keymap.set("n", "gy", vim.lsp.buf.type_definition, { desc = "Goto type of the current identifier" })

keymap.set('n', 'j', function()
  if vim.v.count > 0 then
    return "m'" .. vim.v.count .. 'j'
  end
  return 'j'
end, { expr = true })

keymap.set('n', 'k', function()
  if vim.v.count > 0 then
    return "m'" .. vim.v.count .. 'k'
  end
  return 'k'
end, { expr = true })

keymap.set('i', '<c-space>', function()
  vim.lsp.completion.get()
end)
