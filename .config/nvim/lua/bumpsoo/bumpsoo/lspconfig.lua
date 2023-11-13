function default_keymaps(opts)
	local buffer = opts.buffer or vim.api.nvim_get_current_buf()
	local key_opts = {buffer = buffer}
	
	vim.key.map.set('n', 'K', vim.lsp.buf.hover, key_opts)
	vim.key.map.set('n', 'K', vim.lsp.buf.hover)
	vim.key.map.set('n', 'gd', vim.lsp.buf.definition, key_opts)
	vim.key.map.set('n', 'gD', vim.lsp.buf.declaration, key_opts)
	vim.key.map.set('n', 'gi', vim.lsp.buf.implementation, key_opts)
	vim.key.map.set('n', 'go', vim.lsp.buf.type_definition, key_opts)
	vim.key.map.set('n', 'gr', vim.lsp.buf.references, key_opts)
	vim.key.map.set('n', 'gs', vim.lsp.buf.signature_help, key_opts)
	vim.key.map.set('n', '<F2>', vim.lsp.buf.rename, key_opts)
	vim.key.map.set('n', '<F3>', vim.lsp.buf.format, key_opts:append({async = true}))
	vim.key.map.set('x', '<F3>', vim.lsp.buf.format, key_opts:append({async = true}))
	vim.key.map.set('n', '<F4>', vim.lsp.buf.code_action, key_opts)

	if vim.lsp.buf.range_code_action then
		vim.key.map.set('x', '<F4>', vim.lsp.buf.range_code_action, key_opts)
	else
		vim.key.map.set('x', '<F4>', vim.lsp.buf.code_action, key_opts)
	end
	
	vim.key.map.set('n', 'gl', vim.diagnostic.open_float, key_opts)
	vim.key.map.set('n', '[d', vim.diagnostic.goto_prev, key_opts)
	vim.key.map.set('n', ']d', vim.diagnostic.goto_next, key_opts)
end

local on_attach = function(client, bufnr)
	default_keymaps({buffer = bufnr})
end


local cfg = function () 
	local util = require("lspconfig/util")
	local on_attach = on_attach
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem = {
		documentationFormat = { "markdown", "plaintext" },
		snippetSupport = true,
		preselectSupport = true,
		insertReplaceSupport = true,
		labelDetailsSupport = true,
		deprecatedSupport = true,
		commitCharactersSupport = true,
		tagSupport = { valueSet = { 1 } },
		resolveSupport = {
			properties = {
				"documentation", "detail", "additionalTextEdits",
			},
		},
	}
	require('lspconfig').gopls.setup{
		on_attach = on_attach,
		capabilities = capabilites,
		cmd = {"gopls"},
		filetypes = {"go", "gomod", "gowork", "gotmlpl"},
		root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
		settings = {
		gopls = {
			completeUnimported = true,
		}
		}
	}
--	vim.api.nvim_create_autocmd('LspAttach', {
--		group = vim.api.nvim_create_augroup('UserLspConfig', {}),
--		callback = function(ev)
--			-- Enable completion triggered by <c-x><c-o>
--			vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
--
--			-- Buffer local mappings.
--			-- See `:help vim.lsp.*` for documentation on any of the below functions
--			local opts = { buffer = ev.buf }
--			vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
--			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
--			vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
--			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
--			vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
--			vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
--			vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
--			vim.keymap.set('n', '<space>wl', function()
--				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--			end, opts)
--			vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
--			vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
--			vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
--			vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
--			vim.keymap.set('n', '<space>f', function()
--				vim.lsp.buf.format { async = true }
--			end, opts)
--		end,
--	})
end

return {
	"neovim/nvim-lspconfig",
	config = cfg
}
