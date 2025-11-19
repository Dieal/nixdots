local util = require('dieal.util.functions')
local nmap = util.nmap
local imap = util.imap
local vmap = util.vmap

local personalVaultPath = vim.fn.expand("~/shared/vaults/wiki") .. "/" -- Remember to add trailing slash at the end 
if vim.fn.isdirectory(personalVaultPath) == 0 then
  print("Vault " .. personalVaultPath .. " doesn't exist. Creating it...")
  os.execute('mkdir ' .. personalVaultPath)
  print("Created " .. personalVaultPath)
end
nmap("<leader>oo", "<cmd>e " .. personalVaultPath .. "index.md<CR>", "[O]bsidian [O]pen Index")

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.cmd("setlocal wrap")
  end,
  pattern = "*.md",
  desc = "Enables wrap on Markdown Files",
})

return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      image = {}
    }
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    opts = {
    },
    init = function()
      vim.keymap.set({"n"}, "<leader>snt", "<CMD>TodoTelescope cwd=" .. personalVaultPath .. "<CR>")
      vim.keymap.set({"n"}, "<leader>spt", "<CMD>TodoTelescope<CR>")
    end
  },
  {
    "backdround/global-note.nvim",
    config = function() 
      require("global-note").setup({
        filename = "scratch.md",
        directory = personalVaultPath,
      })
      vim.keymap.set({ "i", "n" }, "<M-s>", require("global-note").toggle_note)
    end
  },

  -- Markdown Utils
  {
    "tadmccorkle/markdown.nvim",
    enabled = false,
    lazy = true,
    ft = "markdown",
    opts = {
      -- configuration here or empty for defaults
    },
    config = function(_, opts)
      require("markdown").setup(opts)
    end,
  },

  -- Awesome Markdown Preview Plugin
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    opts = {
      markdown_inline = {
        checkboxes = {
          unchecked = { text = "▢", hl = "MarkviewCheckboxUnchecked", scope_hl = "MarkviewCheckboxUnchecked" },
        }
      },
      preview = {
        enable = true,
        -- enable_hybrid_mode = true,
        -- hybrid_modes = { "n" }, -- Vim-modes where `hybrid mode` is enabled
        -- linewise_hybrid_mode = true,
      },
    },
    init = function()
      vim.api.nvim_set_keymap("n", "<leader>ms", "<CMD>Markview splitToggle<CR>", { desc = "Toggles split" });
    end
  },

  -- Smart and customizable markdown toggling for Neovim. Provides intuitive
  -- commands for quotes, headings, lists, and checkboxes.
  {
    "roodolv/markdown-toggle.nvim",
    -- dir = "~/coding/forks/markdown-toggle.nvim", -- Point to your local fork
    -- dev = true,                       -- Enable development mode
    ft = "markdown",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown", "markdown.mdx" },
        callback = function()
          vim.opt_local.autoindent = true
        end,
      })
    end,
    opts = {
      box_table = { "x", "!", ">" },
      list_table = { "-", "*", "+" },
      enable_autolist = true,
      keymaps = {
        toggle = {
          ["<C-q>"] = "quote",
          ["<M-l>"] = "list_cycle",
          ["<C-M-l>"] = "list",
          ["<M-o>"] = "olist",
          ["<M-x>"] = "checkbox",
          ["<C-M-x>"] = "checkbox_cycle",
          ["<C-h>"] = "heading",
          ["<Leader><C-h>"] = "heading_toggle",
        },
      },
    }
  },

  -- Obsidian Integration
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    enabled = true,
    lazy = true,
    ft = "markdown",
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "ibhagwan/fzf-lua",
    },
    init = function()
      vim.opt.conceallevel = 1 -- concealment features
    end,
    config = function ()
      require('obsidian').setup({
        checkbox = {
          order = { " ", "x" },
        },
        ui = {
          enable = false,
        },
        workspaces = { { name = "wiki", path = personalVaultPath, }, },
        daily_notes = {
          folder = "fleeting/dailies",
          -- Optional, if you want to change the date format for the ID of daily notes.
          date_format = "%d-%m-%Y",
          -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
          template = "daily.md",
        },
        templates = {
          folder = "templates/",
          date_format = "%d-%m-%Y",
          time_format = "%H:%M",
        },

        completition = {
          blink = true,
          nvim_cmp = false,
        },

        legacy_commands = false,

        ---@param url string
        follow_url_func = function(url)
          -- Open the URL in the default web browser.
          vim.fn.jobstart({"xdg-open", url})  -- linux
        end,

        picker = {
          name = "fzf-lua",
        },
      })

      nmap("<CR>", function()
          return require("obsidian").util.smart_action()
      end)
      nmap("<leader>oq", "<cmd>Obsidian quick_switch<CR>", "[O]bsidian [Q]uickswitch")
      nmap("<leader>ob", "<cmd>Obsidian backlinks<CR>", "[O]bsidian [B]acklinks")
      nmap("<leader>ol", "<cmd>Obsidian links<CR>", "[O]bsidian [L]nks")
      nmap("<leader>otc", "<cmd>Obsidian toc<CR>", "[O]bsidian [T]able of [C]ontents")
      nmap("<leader>otp", "<cmd>Obsidian template<CR>", "[O]bsidian [T]em[p]late")
      nmap("<leader>otg", "<cmd>Obsidian tags<CR>", "[O]bsidian [T]a[g]s")
      nmap("<leader>os", "<cmd>Obsidian search<CR>", "[O]bsidian [S]earch")
      nmap("<leader>odn", "<cmd>Obsidian today<CR>", "[O]bsidian [D]aily [N]ote")
      nmap("<leader>odl", "<cmd>Obsidian dailies<CR>", "[O]bsidian [D]ailies [L]ist")

      --[[ nmap("<leader>ot", function ()
        vim.ui.input({ prompt = "Inserisci il nome del tag" }, function (input)
          vim.cmd("ObsidianTags " .. input)
        end)
      end, "[O]bsidian [T]ags")
 ]]
      nmap("<leader>on", function ()
        vim.ui.input({ prompt = "Inserisci il nome/path della nuova nota" }, function (input)
          vim.cmd("Obsidian new " .. input .. ".md")
        end)
      end, "[O]bsidian [N]ew Note")
    end
  },
}

