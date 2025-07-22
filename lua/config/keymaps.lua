-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<ESC>", { silent = true })
vim.keymap.set("n", "gl", "$", { silent = true })
vim.keymap.set("n", "gh", "_", { silent = true })
vim.keymap.set("n", "<leader>y", "Flash", { silent = true, desc = "Jump to Flash" })
vim.keymap.set("v", "io", "<ESC>")

-- vim.keymap.set("n", "<leader>h", "<cmd>Hardtime toggle<CR>")
vim.keymap.set("n", "<leader>h", function()
  if require("hardtime").is_plugin_enabled then
    require("hardtime").disable()
    vim.notify("Hardtime disabled !")
  else
    require("hardtime").enable()
    vim.notify("Hardtime enabled !")
  end
end, { desc = "Toggle Hardtime" })

vim.keymap.set("n", "<leader>gl", function()
  vim.cmd(":GitBlameToggle")
  vim.notify("Blamer toggled!", vim.log.levels.INFO, { title = "Git Blame" })
end, {
  noremap = true,
  silent = true,
  desc = "Toggle Blamer",
})

local function insertFullPath()
  local relpath = string.gsub(vim.fn.expand("%:."), "^%./", "")
  vim.fn.setreg("+", relpath) -- write to clippoard
  vim.notify('Copied "' .. relpath .. '" to the clipboard!')
end

vim.keymap.set(
  "n",
  "<leader>pc",
  insertFullPath,
  { noremap = true, silent = true, desc = "Copy current file relative path" }
)
