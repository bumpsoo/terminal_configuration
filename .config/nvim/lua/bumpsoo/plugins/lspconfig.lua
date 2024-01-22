local config = function() 
  -- Add additional capabilities supported by nvim-cmp
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  local lspconfig = require('lspconfig')
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    -- Mappings.
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gD', '<cmd>tab split | lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>tab split | lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  end

  -- Enable some language servers with the additional
  -- completion capabilities offered by nvim-cmp
  local servers = { 'gopls', 'erlangls', 'tsserver'}
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end
  lspconfig.volar.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {
      'typescript',
      'javascript',
      'javascriptreact',
      'typescriptreact',
      'vue',
      'json'
    },
    init_options = {
      typescript = {
        tsdk = '/usr/lib/node_modules/typescript/lib'
      }
    }
  }
  local luasnip = require 'luasnip'
  local cmp = require 'cmp'
  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
      ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    },
  }
end

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
  },
  config = config
}

