-- ~/.config/nvim/lua/colors/constant_luma.lua

local theme = {}

theme.colors = {
  bg = '#000000', -- background
  fg = '#777777', -- foreground
  black = '#000000', -- color0
  red = '#b10b00', -- color1
  green = '#007232', -- color2
  yellow = '#745b00', -- color3
  blue = '#3123ff', -- color4
  magenta = '#9b0097', -- color5
  cyan = '#006a78', -- color6
  white = '#777777', -- color7
  br_black = '#464646', -- color8
  br_red = '#ff3d2b', -- color9
  br_green = '#00ae50', -- color10
  br_yellow = '#b18c00', -- color11
  br_blue = '#6786ff', -- color12
  br_magenta = '#eb00e4', -- color13
  br_cyan = '#00a3b7', -- color14
  br_white = '#ababab', -- color15
  selection_bg = '#464646',
  selection_fg = '#745b00',
}

theme.setup = function()
  local c = theme.colors
  vim.cmd 'highlight clear'
  if vim.fn.exists 'syntax_on' then
    vim.cmd 'syntax reset'
  end
  vim.o.background = 'dark'
  vim.g.colors_name = 'constant_luma'

  -- UI
  vim.api.nvim_set_hl(0, 'Normal', { fg = c.fg, bg = c.bg })
  vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#111111' })
  vim.api.nvim_set_hl(0, 'Visual', { bg = c.selection_bg, fg = c.selection_fg })
  vim.api.nvim_set_hl(0, 'LineNr', { fg = c.br_black })
  vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = c.white })

  -- Syntax
  vim.api.nvim_set_hl(0, 'Comment', { fg = c.br_black, italic = true })
  vim.api.nvim_set_hl(0, 'Identifier', { fg = c.blue })
  vim.api.nvim_set_hl(0, 'Function', { fg = c.green })
  vim.api.nvim_set_hl(0, 'Statement', { fg = c.red })
  vim.api.nvim_set_hl(0, 'PreProc', { fg = c.magenta })
  vim.api.nvim_set_hl(0, 'Type', { fg = c.yellow })
  vim.api.nvim_set_hl(0, 'Special', { fg = c.cyan })

  -- Diagnostics (if LSP is used)
  vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = c.br_red })
  vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = c.br_yellow })
  vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = c.br_cyan })
  vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = c.br_green })

  vim.api.nvim_set_hl(0, 'NormalFloat', { fg = c.fg, bg = 'none' })
  vim.api.nvim_set_hl(0, 'FloatBorder', { fg = c.fg, bg = 'none' })
  vim.api.nvim_set_hl(0, 'TelescopeNormal', { fg = c.fg, bg = 'none' })
end

return theme
