require("dap").adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "js-debug",
    args = {"${port}"}
  }
}

require("dap").configurations.javascript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
}

-- Add autocompletion to DAP repl
vim.api.nvim_create_autocmd("FileType", {
  pattern = "dap-repl",
  callback = function ()
    require("dap.ext.autocompl").attach()
  end
})

local widgets = require('dap.ui.widgets')

vim.keymap.set("n", "<leader>Gc", function() require("dap").continue() end, { desc = "Continue program execution" })
vim.keymap.set("n", "<leader>Gr", function() require("dap").restart() end, { desc = "Restart debugging session" })
vim.keymap.set("n", "<leader>Gb", function() require("dap").toggle_breakpoint() end, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>Gh", function() require("dap").pause() end, { desc = "Pause program execution" })
vim.keymap.set("n", "<leader>Gi", function() require("dap").step_into() end, { desc = "Step in" })
vim.keymap.set("n", "<leader>Go", function() require("dap").step_out() end, { desc = "Step out" })
vim.keymap.set("n", "<leader>Gn", function()
  require("dap").step_over()
  vim.cmd("normal zz")
end, { desc = "Step to next" })
vim.keymap.set("n", "<leader>Gu", function() require("dap").up() end, { desc = "Go up current stacktrace" })
vim.keymap.set("n", "<leader>Gd", function() require("dap").down() end, { desc = "Go down current stacktrace" })
vim.keymap.set("n", "<leader>GR", function() require("dap").repl.toggle() end, { desc = "Toggle REPL" })
vim.keymap.set("n", "<leader>Gt", function() require("dap").close() end, { desc = "End debug session" })

vim.keymap.set("n", "<leader>Gvs", function() widgets.centered_float(widgets.scopes) end, { desc = "View scopes" })
vim.keymap.set("n", "<leader>Gvf", function() widgets.centered_float(widgets.frames) end, { desc = "View frames" })

-- Helix binds for reference
-- l    Launch debug target                        
-- r    Restart debugging session                  
-- b    Toggle breakpoint                          
-- c    Continue program execution                 
-- h    Pause program execution                    
-- i    Step in                                    
-- o    Step out                                   
-- n    Step to next                               

-- v    List variables                             
-- t    End debug session                          
-- C-c  Edit breakpoint condition on current line  
-- C-l  Edit breakpoint log message on current line
-- s    Switch                                     
-- e    Enable exception breakpoints               
-- E    Disable exception breakpoints
