local map = vim.keymap.set

map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General Clear highlights" })


-- format Alt + Ctrl + l
map("n", "<A-C-l>", vim.lsp.buf.format, {})


map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "n" }, "s", "<Nop>", { silent = true, noremap = true })
map({ "n", "v" }, "S", "<cmd>w<cr>", { desc = "Save file" })
-- Move
map({ "n", "v" }, "L", "$", { silent = true, noremap = true })
map({ "n", "v" }, "H", "^", { silent = true, noremap = true })
map({ "n", "v" }, "K", "5k", { silent = true, noremap = true })
map({ "n", "v" }, "J", "5j", { silent = true, noremap = true })


map({ "n" }, "dL", "d$", { silent = true, noremap = true })
map({ "n" }, "dH", "d^", { silent = true, noremap = true })


-- plugins

map({ "n", "v" }, "<leader>e", "<cmd>Neotree toggle reveal=true<CR>", { silent = true, noremap = true })

-- [[telescope]]
--
map("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map("n", "<leader>/", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>;", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })


-- [[bufferline]]
map("n", "=", "<cmd>BufferLineCycleNext<CR>", { desc = "move to next buffer" })
map("n", "-", "<cmd>BufferLineCyclePrev<CR>", { desc = "move to prev buffer" })
map("n", "<leader>b", "<cmd>BufferLinePickClose<CR>", { desc = "close pick buffer" })
map("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", { desc = "close pick buffer" })



map("n", "<leader>i", "<cmd>ToggleTerm<cr>", { desc = "open terminal" })
map("t", "<leader>i", "<C-\\><C-n><cmd>q<cr>", { desc = "quit terminal mode" })
