return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = {"nvim-telescope/telescope.nvim"},
  config = function()
    require("telescope").setup {
      extensions = {
        file_browser = {
          grouped = true,
          hidden = { file_browser = true, folder_browser = true },
        },
      },
    }
    require("telescope").load_extension "file_browser"
    vim.keymap.set("n", "<space>fb", function()
      require("telescope").extensions.file_browser.file_browser()
    end)
  end
}

