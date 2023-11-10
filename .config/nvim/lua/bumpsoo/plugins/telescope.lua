return {
	'nvim-telescope/telescope.nvim', tag = '0.1.4',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>fn', builtin.find_files, {})
		vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})
		vim.keymap.set('n', '<leader>ft', builtin.help_tags, {})
	end
}
