return {
  "eandrju/cellular-automaton.nvim",
  event = "VeryLazy",
  config = function()
    -- game_of_life | make_it_rain
    vim.keymap.set("n", "<leader>ff", "<cmd>CellularAutomaton  game_of_life<CR>")
  end
}
