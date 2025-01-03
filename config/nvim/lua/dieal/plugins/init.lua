return {
  -- NOTE: First, some plugins that don't require any configuration
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Notifications
  'rcarriga/nvim-notify',

  -- Copilot
  {
    "github/copilot.vim",
    config = function()
      vim.cmd ("Copilot enable")

      -- Change mapping to Ctrl Tab
      vim.keymap.set('i', '<C-l>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false
      })
      vim.g.copilot_no_tab_map = true
    end
  },

  -- -- Saves / Restores Sessions
  -- 'tpope/vim-obsession',

  -- Auto pair brackets
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },

  -- Inline Folding (HTML and Tailwind)
  {
    "malbertzard/inline-fold.nvim",
    lazy = true,
    ft = {'php', 'html', 'blade'},
    config = function ()
      require('inline-fold').setup({
        defaultPlaceholder = "…",
        queries = {
          -- Some examples you can use
          html = {
            { pattern = 'class="([^"]*)"' }, -- classes in html
            { pattern = 'href="(.-)"' }, -- hrefs in html
            { pattern = 'src="(.-)"' }, -- HTML img src attribute
          },
          php = {
            { pattern = 'class="([^"]*)"' }, -- classes in html
            { pattern = 'href="(.-)"' }, -- hrefs in html
            { pattern = 'src="(.-)"' }, -- HTML img src attribute
          },
          blade = {
            { pattern = 'class="([^"]*)"' }, -- classes in html
            { pattern = 'href="(.-)"' }, -- hrefs in html
            { pattern = 'src="(.-)"' }, -- HTML img src attribute
          },
        },
      })

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
        pattern = { '*.html', '*.tsx', '*.php' },
        callback = function(_)
          if not require('inline-fold.module').isHidden then
            vim.cmd('InlineFoldToggle')
          end
        end
      })
    end,
  },

  { 'nvim-tree/nvim-web-devicons' },

  -- Terminal
  { 'numToStr/FTerm.nvim', },

  -- Abolish.vim, to keep case when substituting words
  { 'tpope/vim-abolish' },

  -- Programming specific plugins
  {
    'windwp/nvim-ts-autotag',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('nvim-ts-autotag').setup({
        per_filetype = {
          ["blade"] = {
            enable_close = true,
          },
        },
      });
    end
  },

  {
    'mg979/vim-visual-multi',
  },


  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    main = "ibl",
    opts = {
    },
  },

  -- Pretty Notifications
  { 'rcarriga/nvim-notify' },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  {
    'ahmedkhalf/project.nvim',
    config = function()
      require("project_nvim").setup {
        detection_methods = { "pattern" },
        patterns = { ".git" },
        exclude_dirs = { "package.json" },
      }
    end
  },
}
