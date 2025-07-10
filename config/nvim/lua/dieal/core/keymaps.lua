-- [[ Basic Keymaps ]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Yanking to system clipboard
vim.keymap.set("n", '<leader>y', '"+yy', { desc = "Yank to system clipboard "})
vim.keymap.set("v", '<leader>y', '"+y', { desc = "Yank to system clipboard "})

-- Capitalize
vim.keymap.set("n", '<leader>cp', "<cmd>s/\\<./\\u&/g<cr>", { desc = "[c]a[p]italize each word in line"})
vim.keymap.set("v", '<leader>cp', "<cmd>s/\\<./\\u&/g<cr>", { desc = "[c]a[p]italize each word in selection"})


-- Keymaps for better default experience
-- Center Cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'Q', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Split windows navigation
vim.keymap.set('n', '<C-q>', '<C-w>q', { desc = 'Close window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right split window' })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left split window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to higher split window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to lower split window' })

-- TABS
vim.keymap.set('n', '<leader>tn', '<CMD>tabnew<CR>', { desc = '[T]ab [N]ew' })
vim.keymap.set('n', '<leader>tc', '<CMD>tabclose<CR>', { desc = '[T]ab [C]lose' })
vim.keymap.set('n', 'L', '<CMD>tabnext<CR>', { desc = 'Tab Next' })
vim.keymap.set('n', 'H', '<CMD>tabprev<CR>', { desc = 'Tab Previous' })
