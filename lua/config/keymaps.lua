-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "kd", "<esc>A", { desc = "Keluar dari kurung" })

--- Escape from nearest brackets or parenthesses
function EscapePair()
  local closers = { "'", "`", '"', ")" }
  local line = vim.api.nvim_get_current_line()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))

  local after = line:sub(col + 1, -1)

  local closer_col = #after + 1
  local closer_i = nil

  for i, closer in pairs(closers) do
    local cur_index, _ = after:find(closer)

    if cur_index and (cur_index < closer_col) then
      closer_col = cur_index
      closer_i = i
    end
  end

  if closer_i then
    vim.api.nvim_win_set_cursor(0, { row, col + closer_col })
  end
end

vim.keymap.set("i", "kc", "<cmd>lua EscapePair()<CR>", { desc = "Keluar dari parenthesses / brackets terdekat" })
