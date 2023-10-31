-- Leader Keys
vim.g.mapleader = " "
vim.g.localleader = ","
-- Spellcheck Languages
vim.opt.spelllang = {"en_gb","de"}
-- Misc. Settings
vim.opt.autoindent = true
vim.opt.cursorline = true
vim.opt.autowrite = true
vim.opt.wrap = false
-- Indent Settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
-- Load Lazy.nvim as plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("user.plugins")
-- Colorscheme
vim.cmd("colorscheme catppuccin-frappe")
-- vim.g.colors_name = "catpuccin-frappe"
-- vim.api.nvim_set_hl(0, "SpellBad", { cterm=underline, gui=underline })
vim.api.nvim_set_hl(0, "SpellBad", {fg="#e78284", underline=true, italic=true})
-- Keybindings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
-- Luasnip Keybindings
local ls = require('luasnip')
vim.keymap.set({"i"}, "<TAB>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<TAB>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<S-TAB>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})    
-- Spellcheck Keybindings
vim.keymap.set("n", "<localleader>s", function()
  vim.o.spell = not vim.o.spell
  print("spell: " .. tostring(vim.o.spell))
end)
vim.api.nvim_set_keymap("i", "<C-L>", "<c-g>u<Esc>[s1z=`]a<c-g>u", { noremap=true, nowait=true })
vim.api.nvim_set_keymap("n", "<C-L>", "i<c-g>u<Esc>[s1z=`]a<c-g>u<Esc>", { noremap=true, nowait=true })