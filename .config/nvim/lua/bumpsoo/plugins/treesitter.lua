return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local cfg = require("nvim-treesitter.configs")
    cfg.setup({
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      ensure_installed = {
        "json",
        "lua",
        "javascript",
        "typescript",
        "vue",
        "go",
        "yaml",
        'python',
        "terraform",
      },
    })
  end
}
