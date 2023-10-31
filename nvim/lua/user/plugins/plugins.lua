return {
{
    "catppuccin/nvim", name = "catppuccin", priority = 1000
},
{
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = { "BufRead", "BufAdd" },
    build = ":TSUpdate",
    config = function ()
    	local configs = require("nvim-treesitter.configs")

      configs.setup({

          highlight = {
        		enable = true,
        		additional_vim_regex_highlighting = false
        	},       
          ensure_installed = {
            "latex",
            "lua",
            "vimdoc",
            "vim",
        }
      })
    end
  },
  {
  	"L3MON4D3/LuaSnip",
    lazy = true,
    event = { "BufRead", "BufAdd" },
  	-- follow latest release.
  	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  	-- install jsregexp (optional!).
  	build = "make install_jsregexp",
  },
  {
    "https://github.com/lervag/vimtex",
    lazy = true,
    ft = "tex",
    config = function ()
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_view_skim_sync = 1
      vim.g.vimtex_view_skim_activeate = 1
      -- vim.g.vimtex_compiler_method = "tectonic"
      -- vim.g.vimtex_compiler_tectonic = true
      vim.opt.conceallevel = 1

       vim.opt.spell = true
    end
  },
  -- {
  --   "iurimateus/luasnip-latex-snippets.nvim",
  --   lazy = true,
  --   ft = {"tex"},
  --   config = function()
  --       require'luasnip-latex-snippets'.setup({ use_treesitter = true})
  --       -- or setup({ use_treesitter = true })
  --       require("luasnip").config.setup { enable_autosnippets = true }
  --   end,
  -- },
  {
    "evesdropper/luasnip-latex-snippets.nvim",
    lazy = true,
    ft = "tex",
    config = function()
        require'luasnip-latex-snippets'.setup({ use_treesitter = true})
        -- or setup({ use_treesitter = true })
        require("luasnip").config.setup { enable_autosnippets = true }
    end,
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.3',
-- or                              , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' }
  }
}

