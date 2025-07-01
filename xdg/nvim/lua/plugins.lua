local lazy = require("lazy")
local packadd = vim.cmd.packadd

packadd "kanagawa.nvim"
vim.cmd.colorscheme "kanagawa"

packadd "mini.nvim"

local selenized_palette = {
  bg_0 = '#103c48',
  bg_1 = '#184956',
  bg_2 = '#2d5b69',
  dim_0 = '#72898f',
  fg_0 = '#adbcbc',
  fg_1 = '#cad8d9',

  red = '#fa5750',
  green = '#75b938',
  yellow = '#dbb32d',
  blue = '#4695f7',
  magenta = '#f275be',
  cyan = '#41c7b9',
  orange = '#ed8649',
  violet = '#af88eb',

  br_red = '#ff665c',
  br_green = '#84c747',
  br_yellow = '#ebc13d',
  br_blue = '#58a3ff',
  br_magenta = '#ff84cd',
  br_cyan = '#53d6c7',
  br_orange = '#fd9456',
  br_violet = '#bd96fa',
}

-- require("mini.base16").setup {
--   palette = {
--     base00 = selenized_palette.bg_0,
--     base01 = selenized_palette.bg_1,
--     base02 = selenized_palette.bg_2,
--     base03 = selenized_palette.dim_0,
--     base04 = selenized_palette.fg_0,
--     base05 = selenized_palette.fg_1,
--     base06 = selenized_palette.bg_0,
--     base07 = selenized_palette.fg_1,
--     base08 = selenized_palette.red,
--     base09 = selenized_palette.blue,
--     base0A = selenized_palette.yellow,
--     base0B = selenized_palette.green,
--     base0C = selenized_palette.orange,
--     base0D = selenized_palette.cyan,
--     base0E = selenized_palette.violet,
--     base0F = selenized_palette.dim_0,
--   },
-- }

vim.schedule(function ()
  packadd "nvim-treesitter"
  require("nvim-treesitter.configs").setup {
    highlight = { enable = true },
    ensure_installed = { "zig", "javascript", "typescript", "svelte", "scss", "css", "html", "java", "cpp" },
  }
end)

packadd "nvim-lspconfig"
vim.lsp.enable({"lua_ls", "svelte", "clangd", "zls", "ocamllsp", "rust_analyzer"})

local function snacks_loader()
  local loaded = false
  return function()
    if not loaded then
      packadd "snacks.nvim"
      require("snacks").setup {
        picker = {
          ui_select = true,
          layout = {
            preset = "ivy",
            layout = { position = "bottom" }
          }
        }
      }
    end
    loaded = true
  end
end
local load_snacks = snacks_loader()

lazy.keymap("n", "<leader>f", function (opts)
  load_snacks()
  vim.keymap.set("n", "<leader>f", Snacks.picker.files, opts)
end, { desc = "Search files" })

lazy.keymap("n", "<leader>/", function (opts)
  load_snacks()
  vim.keymap.set("n", "<leader>/", Snacks.picker.grep, opts)
end, { desc = "Grep files" })

lazy.keymap("n", "<leader>s", function (opts)
  load_snacks()
  vim.keymap.set("n", "<leader>s", Snacks.picker.lsp_symbols, opts)
end, { desc = "Search LSP symbols" })

lazy.keymap("n", "<leader>*", function (opts)
  load_snacks()
  vim.keymap.set("n", "<leader>*", function() Snacks.picker() end, opts)
end, { desc = "Search all pickers" })

function mini_loader()
  local loaded = false
  return function()
    if not loaded then
      packadd "mini.nvim"
      require("mini.pairs").setup {
        mappings = {
          ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\][^%\'%\"%a]' },
          ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\][^%\'%\"%a]' },
          ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\][^%\'%\"%a]' },

          [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
          [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
          ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },

          ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^%a\\][^%a]', register = { cr = false } },
          ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%<%a\\][^%a]', register = { cr = false } },
          ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^`\\].', register = { cr = false } },
        },
      }
      require("mini.jump2d").setup {
        view = { dim = true },
        mappings = {
          start_jumping = "",
        }
      }
      require("mini.icons").setup { style = "ascii" }
      MiniIcons.mock_nvim_web_devicons()
    end
    loaded = true
  end
end
local load_mini = mini_loader()

lazy.event("InsertEnter", function() load_mini() end)

lazy.keymap("n", "gs", function(opts)
  load_mini()
  vim.keymap.set("n", "gs", function()
    MiniJump2d.start(MiniJump2d.builtin_opts.single_character)
  end, opts)
end, { desc = "Goto word" })

local operator
function _G.remote_jump_operator(foo)
  local start_pos = vim.api.nvim_buf_get_mark(0, "[")
  local end_pos = vim.api.nvim_buf_get_mark(0, "]")
  vim.cmd "normal! m'"
  vim.api.nvim_win_set_cursor(0, start_pos)
  vim.cmd('normal! v')
  vim.api.nvim_win_set_cursor(0, end_pos)
  vim.api.nvim_input(vim.api.nvim_replace_termcodes(operator .. '<C-o>', true, false, true))
end

lazy.keymap_action("o", "r", load_mini, function()
  vim.o.operatorfunc = "v:lua.remote_jump_operator"
  operator = vim.v.operator
  vim.api.nvim_input(vim.api.nvim_replace_termcodes('<esc>', true, false, true))
  vim.schedule(function()
    MiniJump2d.start(MiniJump2d.builtin_opts.single_character)
    vim.api.nvim_input("g@")
  end)
end, { desc = "Goto to remote word" })


local function load_snipe()
  load_mini()
  vim.opt.rtp:append(vim.env.HOME .. "/maintain/snipe.nvim")
  require("snipe").setup { ui = { preselect_current = false, text_align = "file-first" } }
end

lazy.keymap("n", "go", function(opts)
  load_snipe()
  vim.keymap.set("n", "go", require("snipe").open_buffer_menu, opts)
end, { desc = "Open snipe menu" })

-- local function load_blink()
--   load_mini()
--   packadd "blink.cmp"
--   require("blink.cmp").setup {
--     completion = {
--       menu = {
--         draw = {
--           components = {
--             kind_icon = {
--               text = function(ctx)
--                 local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
--                 return kind_icon
--               end,
--               -- (optional) use highlights from mini.icons
--               highlight = function(ctx)
--                 local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
--                 return hl
--               end,
--             },
--             kind = {
--               -- (optional) use highlights from mini.icons
--               highlight = function(ctx)
--                 local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
--                 return hl
--               end,
--             }
--           }
--         }
--       }
--     }
--   }
-- end
-- lazy.event("InsertEnter", load_blink)

-- TODO lazy load this
packadd "plenary.nvim"
packadd "neogit"

vim.schedule(function() vim.cmd.helptags "ALL" end)
