return {
  {
    'jwalton512/vim-blade',
    ft = { 'blade' },
  },

  {
    "adalessa/laravel.nvim",
    dependencies = {
      "tpope/vim-dotenv",
      -- "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
      "kevinhwang91/promise-async",
    },
    config = true,
    lazy = true,
    ft = { "php" },
    cmd = { "Laravel" },
    opts = {
      features = {
        pickers = {
          provider = 'fzf-lua'
        }
      }
    },
    keys = {
      { "<leader>la", ":Laravel artisan<cr>" },
      { "<leader>lr", ":Laravel routes<cr>" },
      { "<leader>lm", ":Laravel related<cr>" },
    },
  }
}
