local M = {}

function M.keymap_action(mode, lhs, before, action, opts)
  vim.keymap.set(mode, lhs, function()
    before()
    action()
    vim.keymap.del(mode, lhs)
    vim.keymap.set(mode, lhs, action, opts)
  end, opts)
end

function M.keymap(mode, lhs, callback, opts)
  vim.keymap.set(mode, lhs, function()
    vim.keymap.del(mode, lhs)
    callback(opts)
    vim.api.nvim_input(vim.api.nvim_replace_termcodes(lhs, true, false, true)) -- replay keybind
  end, opts)
end

function M.command(c, callback)
  vim.api.nvim_create_user_command(c, function(cr)
    local args = not vim.tbl_isempty(cr.fargs) and table.concat(cr.fargs, " ") or nil
    vim.api.nvim_del_user_command(c) -- remove stub command
    callback()
    vim.cmd(c .. (args and (" " .. args) or ""))
  end, { nargs = "*" })
end

function M.event(ev, callback)
  vim.api.nvim_create_autocmd(ev, {
    once = true,
    callback = callback,
  })
end

function M.require(mod, callback)
  package.preload[mod] = function()
    package.loaded[mod] = nil
    package.preload[mod] = nil
    return callback()
  end
end

return M
