return {
  -- NOTE: First, some plugins that don't require any configuration
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  -- 'tpope/vim-sleuth',

  -- Notifications
  'rcarriga/nvim-notify',

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    opts = {
      -- See Configuration section for options
    },
    config = function()
      vim.cmd("Copilot disable") -- Disables copilot by default
    end,
    -- See Commands section for default commands if you want to lazy load on them
  },

  {
    "ahdzib-maya/remote-sshfs.nvim",
    branch = "fzf.nvim",
    opts = {
      -- Refer to the configuration section below
      -- or leave empty for defaults
      picker = "fzf",
    },
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

  { 'mg979/vim-visual-multi', },


  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    main = "ibl",
    opts = {
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Folding
  {
    'kevinhwang91/nvim-ufo',
    -- enabled = false,
    dependencies = {
      'kevinhwang91/promise-async',
    },
    config = function()
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      vim.keymap.set('n', 'zO', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zC', require('ufo').closeAllFolds)

      require('ufo').setup()
    end,
  },

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
