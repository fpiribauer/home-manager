
local function metals_status()
  return vim.g["metals_status"] or ""
end
require('lualine').setup(
{
  options = { theme = 'gruvbox-material' },
  sections = {
    lualine_a = {'mode' },
    lualine_b = {'branch', 'diff' },
    lualine_c = {'filename', metals_status },
    lualine_x = {'encoding', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  }
})
