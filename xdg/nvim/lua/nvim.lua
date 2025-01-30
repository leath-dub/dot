-- OPTIONS

local g = vim.g
local opt = vim.opt

g.mapleader = " "
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.smartindent = true
opt.guicursor = ""
opt.showmode = false
opt.signcolumn = "yes"
opt.ignorecase = true
opt.background = "dark"
opt.exrc = true

opt.completeopt = { "menu", "menuone", "noinsert", "noselect", "popup" }
-- opt.pumblend = 8

-- Indentation settings
opt.autoindent = true
opt.smartindent = true
opt.cindent = true
opt.shiftwidth = 2
opt.expandtab = true
opt.tabstop = 2

opt.shell = "fish"

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank({ timeout = 100 }) end
})

-- KEYMAPS

local keymap = vim.keymap

-- Goated remap!
keymap.set("n", "gw", "<c-w>")

keymap.set("n", "ga", "<c-^>", { desc = "Go to previously accessed buffer", noremap = true })
keymap.set({ "n", "v" }, "<leader>y", '"+y', { noremap = true })
keymap.set({ "n", "v" }, "<leader>Y", '"+yg_', { noremap = true }) keymap.set({ "n", "v" }, "<leader>p", '"+p', { noremap = true })
keymap.set({ "n", "v" }, "<leader>P", '"+P', { noremap = true })

-- Press yc to copy unamed(") register to system(*) register
local function regmove(r1, r2) vim.fn.setreg(r1, vim.fn.getreg(r2)) end
keymap.set("n", "yc", function() regmove('+', '"') end, { noremap = true }) -- move contents of anon register to system cliboard register

-- Open neovim messages window
keymap.set("n", "ms", ":messages<cr>", { noremap = true })

-- Run last make command
-- If you don't use dispatch.vim change "Make" -> "make"
keymap.set("n", "mk", ":Make<up><cr>", { noremap = true })

-- Quick fix list stuff
keymap.set("n", "co", ":copen<cr>", { noremap = true })

-- Terminal bindings
keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { noremap = true })

-- Async commands

local function async_grep(args)
  local grep_prg = vim.opt.grepprg:get() .. " " .. args
  local grep_cmd = { "sh", "-c", grep_prg }
  -- local grep_cmd = vim.tbl_filter(function (item) return item:len() ~= 0 end, vim.split(grep_prg, " ", { trimempty = true }))

  vim.fn.setqflist({}) -- clear the quickfix list

  vim.system(grep_cmd, { stdout = vim.schedule_wrap(function (err, data)
    if data ~= nil then
      vim.fn.setqflist({}, "a", {
        lines = vim.split(data, "\n", { trimempty = true }),
        efm = table.concat(vim.opt.grepformat:get(), " "),
      })
    end
    vim.cmd.redraw()
  end), text = true})

  vim.cmd.copen()
end

vim.api.nvim_create_user_command("Grep", function(c)
  async_grep(c.args)
end, { nargs = "+" })

-- keymap.set("n", "<leader>g", ":Grep ")

-- keymap.set("n", "gr", function()
--   -- vim.cmd(":Grep " .. string.format("\\b%s\\b", vim.fn.expand("<cword>")))
--   vim.cmd(":Grep -w " .. vim.fn.expand("<cword>"))
-- end, { nowait = true })

local function async_find(args)
  local find_cmd = {"fd"}

  for _, arg in ipairs(args) do
    if arg == "~" then
      arg = vim.uv.os_homedir()
    end
    table.insert(find_cmd, arg)
  end

  vim.fn.setqflist({}) -- clear the quickfix list

  vim.system(find_cmd, { stdout = vim.schedule_wrap(function (err, data)
    if data ~= nil then
      vim.fn.setqflist({}, "a", {
        lines = vim.split(data, "\n", { trimempty = true }),
        efm = "%f",
      })
    end
    vim.cmd.redraw()
  end), text = true})

  vim.cmd.copen()
end

vim.api.nvim_create_user_command("Find", function(c)
  async_find(c.fargs)
end, { nargs = "+" })

-- keymap.set("n", "<leader>f", ":Find ")

local function async_make(args)
  local make_prg = vim.opt.makeprg:get()
  for _, arg in ipairs(args) do
    if arg == "~" then
      arg = vim.uv.os_homedir()
    end
    make_prg = make_prg .. " " .. arg
  end
  local make_cmd = { "sh", "-c", make_prg }

  vim.fn.setqflist({}) -- clear the quickfix list

  local output_handler = vim.schedule_wrap(function (err, data)
    if data ~= nil then
      vim.fn.setqflist({}, "a", {
        lines = vim.split(data, "\n", { trimempty = true }),
        efm = vim.opt.errorformat:get()[1],
      })
    end
    vim.cmd.redraw()
  end)

  vim.system(make_cmd, { stdout = output_handler, stderr = output_handler, text = true})

  vim.cmd.copen()
end

vim.api.nvim_create_user_command("Make", function(c)
  async_make(c.fargs)
end, { nargs = "*" })
