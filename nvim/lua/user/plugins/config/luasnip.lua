print("Loaded Luasnip Config")
local ls = require("luasnip")
local config = ls.config

-- Luasnip Keybindings
vim.keymap.set({ "i" }, "<C-F>", function() ls.expand() end, { silent = true })
vim.keymap.set({ "i", "s" }, "<TAB>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<S-TAB>", function() ls.jump(-1) end, { silent = true })

-- Unneeded cycle options keybind
vim.keymap.set({ "i", "s" }, "<C-E>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

-- Luasnip Config Options
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets/" })
config.set_config({
  history = true,
  updateevents = "TextChanged, TextChangedI",
  enable_autosnippets = true,
  ext_opts = {
    [require("luasnip.util.types").choiceNode] = {
      activee = {
        virt_text = { { "" } }
      }
    }
  },
})
