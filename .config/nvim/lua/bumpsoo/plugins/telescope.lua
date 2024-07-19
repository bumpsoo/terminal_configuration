return {
  'nvim-telescope/telescope.nvim', tag = '0.1.4',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'BurntSushi/ripgrep'
  },
  config = function()
    local telescope = require("telescope")
    local telescopeConfig = require("telescope.config")
    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
    table.insert(vimgrep_arguments, "--hidden")
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")
    telescope.setup({
      defaults = {
        vimgrep_arguments = vimgrep_arguments,
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
    })
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>ft', builtin.help_tags, {})
  end
}
