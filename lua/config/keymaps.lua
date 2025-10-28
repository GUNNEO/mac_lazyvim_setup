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
keymap.set("n", "<leader>cp", ":Cppath<CR>", { noremap = true, desc = "copy current file path" })

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

-- open current file
keymap.set("n", "<leader>op", "<cmd>!open '%'<CR>", { noremap = true, silent = true, desc = "open file" })
