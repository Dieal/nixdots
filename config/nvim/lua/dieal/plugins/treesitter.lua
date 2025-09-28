return {
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    opts = {
      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = {
        'html',
        'css',
        'typescript',
        'javascript',
        'vue',

        'php',

        'python',
        'java',

        'lua',
        'vimdoc',
        'vim',
        'yaml',

        'markdown',
      },

      auto_install = false,

      ignore_install = { 'dart' },

      highlight = { enable = true },
      indent = {
        enable = false,
        disable = { 'dart, php, yaml, yml' },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>',
          node_incremental = '<c-space>',
          scope_incremental = '<c-s>',
          node_decremental = '<M-space>',
        },
      },
      -- textobjects = {
      --   select = {
      --     enable = true,
      --     lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      --     keymaps = {
      --       -- You can use the capture groups defined in textobjects.scm
      --       ['aa'] = '@parameter.outer',
      --       ['ia'] = '@parameter.inner',
      --       ['af'] = '@function.outer',
      --       ['if'] = '@function.inner',
      --       ['ac'] = '@class.outer',
      --       ['ic'] = '@class.inner',
      --     },
      --   },
      --   move = {
      --     enable = true,
      --     set_jumps = true, -- whether to set jumps in the jumplist
      --     goto_next_start = {
      --       [']m'] = '@function.outer',
      --       [']]'] = '@class.outer',
      --     },
      --     goto_next_end = {
      --       [']M'] = '@function.outer',
      --       [']['] = '@class.outer',
      --     },
      --     goto_previous_start = {
      --       ['[m'] = '@function.outer',
      --       ['[['] = '@class.outer',
      --     },
      --     goto_previous_end = {
      --       ['[M'] = '@function.outer',
      --       ['[]'] = '@class.outer',
      --     },
      --   },
      --   swap = {
      --     enable = true,
      --     swap_next = {
      --       ['<leader>a'] = '@parameter.inner',
      --     },
      --     swap_previous = {
      --       ['<leader>A'] = '@parameter.inner',
      --     },
      --   },
      -- },

    },
    config = function(_, opts)
      --[[
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

      -- Laravel Blade Parser
      -- https://github.com/EmranMR/tree-sitter-blade/discussions/19#discussion-5400675
      -- Had to configure injections and highlights
      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }

      vim.filetype.add({
        pattern = {
          ['.*%.blade%.php'] = 'blade',
        },
      })
]]
      -- [[ Configure Treesitter ]]
      -- See `:help nvim-treesitter`
      require('nvim-treesitter.configs').setup(opts)
    end
  },

  {
    'NMAC427/guess-indent.nvim',
    enabled = true,
    config = function() require('guess-indent').setup {} end,
  },

  -- Neovim plugin for splitting/joining blocks of code
  {
    'Wansmer/treesj',
    keys = { '<space>tm', '<space>tj', '<space>ts' },     -- [T]ree [M]..., [T]ree [j]..., [T]ree [S]plit
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
    config = function()
      require('treesj').setup({ --[[ your config ]] })
    end,
  }
}
