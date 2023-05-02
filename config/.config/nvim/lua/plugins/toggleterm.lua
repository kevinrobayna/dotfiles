return {
  "akinsho/toggleterm.nvim",
  event = "VeryLazy",
  opts = {
    size = 20,
    open_mapping = [[<c-t>]],
    hide_numbers = true,
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "curved",
    },
  },
}
