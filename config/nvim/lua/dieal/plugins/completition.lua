return {

  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',

    version = '*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-e: Hide menu
      -- C-k: Toggle signature help
      --
      -- See the full "keymap" documentation for information on defining your own keymap.
      completion = {
        list = {
          selection = { preselect = false, auto_insert = true }
        },
      },
      keymap = {
        preset = 'default',
        ['<CR>'] = { 'accept', 'fallback' },
        ['<C-a>'] = { 'show' },
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<C-k>'] = { 'select_next', 'fallback_to_mappings' },

        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
      },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'normal'
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- Blink.cmp uses a Rust fuzzy matcher by default for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },

  -- Inline Parameters
  --[[ {
    "ray-x/lsp_signature.nvim",
    lazy = true,
    event = "LspAttach",
    config = function ()
      local plugin = require('lsp_signature')
      plugin.on_attach({
        toggle_key = '<C-s>',
      })
    end
  } ]]

  -- {
  --   -- Autocompletion
  --   'hrsh7th/nvim-cmp',
  --   event = "InsertEnter", -- Lazy loading when entering in insert mode
  --   dependencies = {
  --     'saadparwaiz1/cmp_luasnip',
  --
  --     -- Adds LSP completion capabilities
  --     'hrsh7th/cmp-nvim-lsp',
  --     'hrsh7th/cmp-path', -- source for file system paths
  --     'hrsh7th/cmp-buffer', -- source for text in buffer
  --
  --     -- LSP Pittograms
  --     'onsails/lspkind.nvim',
  --   },
  --
  --   -- See `:help cmp`
  --   config = function()
  --     local cmp = require 'cmp'
  --     local lspkind = require('lspkind')
  --     local luasnip = require 'luasnip'
  --
  --     cmp.setup {
  --       completion = { -- How the completion menu works
  --         completeopt = "menu,menuone,preview,noselect", -- :h completeopt
  --       },
  --       snippet = { -- Config how nvim-cmp interacts with snippet engine
  --         expand = function(args)
  --           luasnip.lsp_expand(args.body)
  --         end,
  --       },
  --       sources = { -- Order matters!
  --         { name = 'nvim_lsp' },
  --         { name = 'buffer' },
  --         { name = 'luasnip' },
  --         { name = 'path' },
  --       },
  --       mapping = cmp.mapping.preset.insert {
  --         ['<C-j>'] = cmp.mapping.select_next_item(),
  --         ['<C-k>'] = cmp.mapping.select_prev_item(),
  --         ['<C-d>'] = cmp.mapping.scroll_docs(-4),
  --         ['<C-f>'] = cmp.mapping.scroll_docs(4),
  --         ['<C-Space>'] = cmp.mapping.complete {}, -- Open nvim-cmp suggestion
  --         ['<C-q>'] = cmp.mapping.abort {}, -- Close window
  --         ["<CR>"] = cmp.mapping({ -- Safely select entries with <CR> (If nothing is selected add a newline as usual.)
  --           i = function(fallback)
  --             if cmp.visible() and cmp.get_active_entry() then
  --               cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
  --             else
  --               fallback()
  --             end
  --           end,
  --           s = cmp.mapping.confirm({ select = true }),
  --           c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
  --         }),
  --         ['<Tab>'] = cmp.mapping(function(fallback)
  --           local ok, _ = pcall(require, 'luasnip')
  --           if not ok then
  --             return
  --           end
  --
  --           if cmp.visible() then
  --             cmp.select_next_item()
  --           elseif luasnip.expand_or_locally_jumpable() then
  --             luasnip.expand_or_jump()
  --           else
  --             fallback()
  --           end
  --         end, { 'i', 's' }),
  --         ['<S-Tab>'] = cmp.mapping(function(fallback)
  --           local ok, _ = pcall(require, 'luasnip')
  --           if not ok then
  --             return
  --           end
  --
  --           if cmp.visible() then
  --             cmp.select_prev_item()
  --           elseif luasnip.locally_jumpable(-1) then
  --             luasnip.jump(-1)
  --           else
  --             fallback()
  --           end
  --         end, { 'i', 's' }),
  --       },
  --       formatting = {
  --         format = lspkind.cmp_format({
  --           mode = 'symbol', -- show only symbol annotations
  --           maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
  --           ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
  --
  --           -- The function below will be called before any actual modifications from lspkind
  --           -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
  --           before = function (entry, vim_item)
  --             return vim_item
  --           end
  --         })
  --       },
  --     }
  --
  --   end
  -- },
}
