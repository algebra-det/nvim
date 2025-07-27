-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<ESC>", { silent = true })
vim.keymap.set("n", "gl", "$", { silent = true })
vim.keymap.set("n", "gh", "_", { silent = true })
vim.keymap.set("n", "<leader>y", "Flash", { silent = true, desc = "Jump to Flash" })
vim.keymap.set("v", "io", "<ESC>", { silent = true, desc = "Exit visual mode" })

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

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.85)
  local height = opts.height or math.floor(vim.o.lines * 0.85)

  -- Calculate the position to center the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create a buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end

  -- Define window configuration
  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal", -- No borders or extra UI elements
    border = "rounded",
  }

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window({ buf = state.floating.buf })
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

-- Example usage:
-- Create a floating window with default dimensions
vim.keymap.set("n", "<leader>t", toggle_terminal, {})
