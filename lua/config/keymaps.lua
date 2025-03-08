-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { noremap = true, silent = true, desc = "clear search highlights" })

-- Delete single character without copying into register
keymap.set("n", "x", '"_x', { noremap = true, silent = true, desc = "delete single character" })

-- Increment/decrement numbers
keymap.set("n", "<leader>=", "<C-a>", { noremap = true, silent = true, desc = "increment" }) -- increment
keymap.set("n", "<leader>0", "<C-x>", { noremap = true, silent = true, desc = "decrement" }) -- decrement

-- File path
keymap.set("n", "<leader>fp", ":echo expand('%:p')<CR>")
vim.api.nvim_create_user_command("Cppath", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
keymap.set("n", "<leader>cf", ":Cppath<CR>", { noremap = true, desc = "copy current file path" })

-- Delete .DS_Store file
vim.api.nvim_create_user_command("CleanDSStoreFiles", function()
  -- Find all .DS_Store files recursively
  local current_dir = vim.fn.getcwd()
  local ds_store_files = vim.fn.systemlist("find " .. current_dir .. " -name .DS_Store")
  for _, file in ipairs(ds_store_files) do
    vim.fn.delete(file) -- Delete each .DS_Store file
  end
  vim.notify("Cleaned all .DS_Store files in the current directory.")
end, {})
keymap.set("n", "<leader>ds", ":CleanDSStoreFiles<CR>", { noremap = true, desc = "clear all ds_store_files" })

-- Vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", { noremap = true, silent = true, desc = "window maximization" }) -- toggle split window maximization

-- Telescope
keymap.set(
  "n",
  "<leader>fs",
  "<cmd>Telescope live_grep<CR>",
  { noremap = true, silent = true, desc = "find string in current_dir" }
) -- find string in current working directory as you type
keymap.set(
  "n",
  "<leader>fw",
  "<cmd>Telescope grep_string<CR>",
  { noremap = true, silent = true, desc = "find string under cursor dir" }
) -- find string under cursor in current working directory

-- Move between buffers
keymap.set("n", "<leader>bn", "<cmd>:bn<CR>", { noremap = true, silent = true, desc = "next buffer" }) -- move to the next buffer
keymap.set("n", "<leader>bp", "<cmd>:bp<CR>", { noremap = true, silent = true, desc = "prev buffer" }) -- move to the previous buffer

-- Auto run file
keymap.set("n", "<leader>ll", "<cmd>!lua %<CR>", { noremap = true, desc = "run lua file" })
keymap.set("n", "<leader>pp", "<cmd>!python3 %<CR>", { noremap = true, desc = "run python file" })
keymap.set(
  "n",
  "<leader>cpp",
  ":w<CR>:!clang++ -g -arch arm64 % -o %:r && %:r<CR>",
  { noremap = true, desc = "run cpp file" }
)

-- Latex
keymap.set("n", "<leader>lt", "<cmd>VimtexCompile<CR>", { noremap = true, silent = true, desc = "compile tex file" })
keymap.set("n", "<leader>lv", "<cmd>VimtexView<CR>", { noremap = true, silent = true, desc = "view tex file" })
keymap.set("n", "<leader>zp", "<cmd>!zathura '%'<CR>", { noremap = true, silent = true, desc = "zathura" })
keymap.set("n", "<leader>op", "<cmd>!open '%'<CR>", { noremap = true, silent = true, desc = "open file" })
