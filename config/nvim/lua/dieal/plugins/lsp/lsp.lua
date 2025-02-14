vim.diagnostic.config({
    virtual_text = {
        prefix = '●', -- You can change this to any character you prefer
        spacing = 4,
    },
    signs = true,
    underline = true,
    update_in_insert = true,
})

local on_attach = function(ev)
    -- local builtin = require('telescope.builtin')
    local bufnr = ev.buf
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>rs', "<cmd>LspRestart<CR>", '[R]estart [S]erver')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    -- LSP
    -- nmap('<leader>bd', builtin.diagnostics, '[B]uffer [D]iagnostics')
    -- nmap('gd', builtin.lsp_definitions, '[G]oto [D]efinitions')
    -- nmap('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
    -- nmap('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    -- nmap('gr', builtin.lsp_references, '[G]oto [R]eferences')

    nmap('<leader>ld', vim.diagnostic.open_float, '[L]ine [D]iagnostics')
    nmap(']d', vim.diagnostic.open_float, 'Next [D]iagnostics')
    nmap('[d', vim.diagnostic.open_float, 'Previous [D]iagnostics')

    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')

    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end


return {
  {
    'neovim/nvim-lspconfig',
    event = { "BufReadPre", "BufNewFile" }, -- Lazy loading
    dependencies = {
      'folke/neodev.nvim', -- Additional lua configuration, makes nvim stuff amazing!
    },
    config = function()
      -- Change the Diagnostic symbols in the sign column (gutter)
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- Setup neovim lua configuration
      require('neodev').setup()

      local servers = {
        volar = {
          filetypes = { "vue", "javascript" },
        },
        cssls = {},
        marksman = {},
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                inlayHints = {
                  variableTypes = false,
                  functionReturnTypes = false,
                  callArgumentNames = false,
                },
                typeCheckingMode = "off",
              }
            }
          }
        },
        yamlls = {},
        emmet_ls = {
          filetypes = { "html", "javascript", "blade", "php", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte", "astro" },
        },
        tailwindcss = {}, -- Make sure to have tailwindcss.config.ts in your project
        phpactor = {
          filetypes = { "php", "blade" },
        },
        html = {
          filetypes = { "html" },
          init_options = {
            configurationSection = { "html", "css", "javascript" },
            embeddedLanguages = {
              css = true,
              javascript = true
            },
            provideFormatter = true
          }
        },
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
        nixd = {
          cmd = { "nixd" },
          settings = {
            nixd = {
              nixpkgs = {
                expr = "import <nixpkgs> { }",
              },
              formatting = {
                command = { "alejandra" }, -- or nixfmt or nixpkgs-fmt
              },
              -- options = {
              --   nixos = {
              --       expr = '(builtins.getFlake "/PATH/TO/FLAKE").nixosConfigurations.CONFIGNAME.options',
              --   },
              --   home_manager = {
              --       expr = '(builtins.getFlake "/PATH/TO/FLAKE").homeConfigurations.CONFIGNAME.options',
              --   },
              -- },
            },
          },
        }
      }

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }

      -- local on_attach = require('dieal.util.lsp').on_attach
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = on_attach,
      })

      local lspconfig = require('lspconfig')
      local checkInstalled = function(server_name)
          local default_config = lspconfig[server_name]
          if default_config and default_config.document_config and default_config.document_config.default_config then
            local cmd = default_config.document_config.default_config.cmd
            if cmd and vim.fn.executable(cmd[1]) == 1 then
              return true
            end
          end
      end

      for server_name, config in pairs(servers) do
        if checkInstalled(server_name) == true then
            lspconfig[server_name].setup {
              capabilities = capabilities,
              settings = config.settings,
              filetypes = (servers[server_name] or {}).filetypes,
              init_options = config.init_options,
            }
        end
      end
    end
  },

  { "Vimjas/vim-python-pep8-indent" },

  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        debug = true,
        sources = {
          -- null_ls.builtins.diagnostics.mypy.with({
          --   extra_args = { "--strict", "--ignore-missing-imports"}
          -- })
        },
      })
    end
  },

  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function ()
      local root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw', '.mvn'}, { upward = true })[1])
      print ("jdtls root directory: " .. (root_dir or "Not Found"))

      -- In this way JDTLS gets attached to each .java buffer
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*.java",
        callback = function()
          require('jdtls').start_or_attach({
            cmd = { 'jdtls' },
            root_dir = root_dir,
            settings = {
              java = {
                maven = { downloadSources = true },
                signatureHelp = { enabled = true },
                inlayHints = { parametersNames = { enabled = 'all' } },
              }
            }
          })
        end
      })
    end,
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
    config = function()
      require("typescript-tools").setup {
        on_attach = on_attach,
        filetypes = {
          "javascript",
          "typescript",
          "vue",
        },
        settings = {
          single_file_support = false,
          tsserver_plugins = {
            "@vue/typescript-plugin",
          },
        },
      }
    end,
  },

}
