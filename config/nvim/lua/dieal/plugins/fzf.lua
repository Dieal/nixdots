return {
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local builtin = require("fzf-lua")
      vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
      vim.keymap.set('n', '<leader>sf', builtin.files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch  [B]uffers' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch  [K]eybindings' })

      -- GREP
      vim.keymap.set('n', '<leader>st', builtin.live_grep, { desc = '[S]earch [T]ext by Grep' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_cword, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>/', builtin.grep_curbuf, { desc = '[/] Fuzzily search in current buffer' })

      -- GIT
      vim.keymap.set('n', '<leader>sgf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
      vim.keymap.set('n', '<leader>sgs', builtin.git_status, { desc = 'Search [G]it [S]tatus' })
      vim.keymap.set('n', '<leader>sgc', builtin.git_commits, { desc = 'Search [G]it [C]ommits' })
      vim.keymap.set('n', '<leader>sgb', builtin.git_branches, { desc = 'Search [G]it [B]ranches' })

      -- MISC
      vim.keymap.set('n', '<leader>sh', builtin.helptags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sm', builtin.manpages, { desc = '[S]earch [M]anpages' })

      -- LSP
      vim.keymap.set('n', '<leader>sd', builtin.lsp_declarations, { desc = '[S]earch [D]eclarations' })
      vim.keymap.set('n', '<leader>sls', builtin.lsp_document_symbols, { desc = '[S]earch [L]sp [S]ymbols' })

      builtin.setup({})
      builtin.register_ui_select()

    end
  },
--[[
  {
    "nvim-telescope/telescope.nvim",
    enable = false,
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          path_display = { "truncate " },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous, -- move to prev result
              ["<C-j>"] = actions.move_selection_next, -- move to next result
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
        },
        extensions = {
          file_browser = {
            theme = 'ivy',
            hijack_netrw = true, -- disables netrw and use telescope-file-browser in its place
          }
        },
      })

      -- Enable telescope fzf native, if installed
      pcall(telescope.load_extension, 'fzf')

      -- -- Enable "Project.nvim" telescope integration
      -- pcall(telescope.load_extension, 'projects')

      -- -- See `:help telescope.builtin`
      -- vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
      -- vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      -- vim.keymap.set('n', '<leader>/', function()
      --   -- You can pass additional configuration to telescope to change theme, layout, etc.
      --   builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      --     winblend = 10,
      --     previewer = false,
      --   })
      -- end, { desc = '[/] Fuzzily search in current buffer' })
      --
      -- -- To hide specific folders (e.g node_modules), add it to .gitignore (there needs to be a git repo), 
      -- -- so that ripgrep will ignore it
      -- vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
      -- vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      -- vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      -- vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      -- vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      -- vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      -- vim.keymap.set('n', '<leader>sls', builtin.lsp_document_symbols, { desc = '[S]earch [L]sp [S]ymbols' })
      -- vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch  [B]uffers' })
      -- vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch  [K]eybindings' })
      --
      -- -- Projects.nvim
      -- vim.keymap.set('n', '<leader>srp', telescope.extensions.projects.projects)
    end,
  }
]]
}
