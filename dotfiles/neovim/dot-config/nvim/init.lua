-- move this later
vim.cmd [[colorscheme quiet]]

-- Handle plugins with lazy.nvim
require("core.lazy")

-- General Neovim keymaps
require("core.keymaps")

-- Other options
require("core.options")