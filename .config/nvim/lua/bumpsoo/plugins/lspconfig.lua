return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'hrsh7th/nvim-cmp',
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		vim.opt.completeopt = { "menu", "menuone", "noselect" }
		local has_words_before = function()
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return
				col ~= 0 and
				vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end
		local feedkey = function(key, mode)
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
		end
		local cmp = require('cmp')
		cmp.setup({
			mapping = {
				['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
				['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
				['<C-Space>'] = cmp.mapping.complete(),
				['<CR>'] = cmp.mapping.confirm {
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				},
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function()
					if cmp.visible() then
						cmp.select_prev_item()
					end
				end, { "i", "s" }),
			},
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
			}, {
				{ name = 'buffer' },
			})
		})
		local capabilities = require('cmp_nvim_lsp').default_capabilities()
		local on_attach = function(client, bufnr)
			local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
			local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
		
			buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
		end
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		local nvim_lsp = require('lspconfig')
		nvim_lsp.gopls.setup{
			cmd = {'gopls'},
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				gopls = {
					experimentalPostfixCompletions = true,
					analyses = {
						unusedparams = true,
						shadow = true,
					},
					staticcheck = true,
					gofumpt = true,
				},
			},
			init_options = {
				usePlaceholders = true,
			}
		}
	end
}

