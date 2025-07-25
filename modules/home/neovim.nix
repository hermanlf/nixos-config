# modules/home/neovim.nix
# ═══════════════════════════════════════════════════════════════════════════════
# 🚀 Custom Neovim Configuration - No External Flakes Required!
# ═══════════════════════════════════════════════════════════════════════════════
# A comprehensive, declarative Neovim setup with full control:
# • Complete LSP support for 15+ languages
# • Beautiful Gruvbox theme matching your system
# • File tree, fuzzy finding, git integration
# • Smart autocomplete and error diagnostics
# • Ergonomic keybindings with leader key workflow
# • Zero dependency on external flakes - just pure NixOS!
# ═══════════════════════════════════════════════════════════════════════════════

{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = false;
    vimAlias = true;
    vimdiffAlias = true;

    # ╭─────────────────────────────────────────────────────────────────────╮
    # │                        📦 ESSENTIAL PLUGINS                        │
    # ╰─────────────────────────────────────────────────────────────────────╯
    plugins = with pkgs.vimPlugins; [
      # 🎨 Theme & Appearance
      gruvbox-nvim                    # Beautiful retro theme
      nvim-web-devicons              # File type icons
      lualine-nvim                   # Elegant status line

      # 🔍 Navigation & Search
      telescope-nvim                 # Fuzzy finder for everything
      telescope-fzf-native-nvim      # FZF integration for better performance
      nvim-tree-lua                  # File explorer sidebar

      # 🚀 LSP & Language Support
      nvim-lspconfig                 # LSP configuration
      mason-nvim                     # LSP server manager
      mason-lspconfig-nvim           # Bridge mason & lspconfig

      # 🔧 Completion & Snippets
      nvim-cmp                       # Completion engine
      cmp-nvim-lsp                   # LSP completion source
      cmp-buffer                     # Buffer completion
      cmp-path                       # Path completion
      cmp-cmdline                    # Command line completion
      luasnip                        # Snippet engine
      cmp_luasnip                    # Snippet completion
      friendly-snippets              # Collection of snippets

      # 🌳 Syntax & Parsing
      (nvim-treesitter.withPlugins (p: [
        p.nix p.typescript p.javascript p.tsx p.json p.html p.css
        p.python p.rust p.c p.cpp p.java p.php p.bash p.lua
        p.markdown p.yaml p.toml p.dockerfile p.sql p.go
        p.perl p.vim p.regex p.comment
      ]))
      nvim-treesitter-textobjects    # Smart text objects

      # 🔧 Git Integration
      gitsigns-nvim                  # Git decorations and commands
      diffview-nvim                  # Beautiful git diff view
      neogit                         # Magit-like git interface

      # 💬 Comments & Text Manipulation
      comment-nvim                   # Smart commenting
      nvim-autopairs                 # Auto close brackets/quotes
      nvim-surround                  # Surround text objects

      # 🔍 Code Navigation & Utilities
      which-key-nvim                 # Show keybind hints
      indent-blankline-nvim          # Indentation guides
      trouble-nvim                   # Pretty diagnostics list
      todo-comments-nvim             # Highlight TODO/FIXME/etc

      # 📁 File Management
      oil-nvim                       # Edit filesystem like a buffer
      
      # 🎯 Productivity
      toggleterm-nvim                # Terminal integration
      persistence-nvim               # Session management
      
      # Essential dependencies
      plenary-nvim                   # Lua utility library
      nui-nvim                       # UI components
    ];

    # ╭─────────────────────────────────────────────────────────────────────╮
    # │                      🛠️  LANGUAGE SERVERS                          │
    # ╰─────────────────────────────────────────────────────────────────────╯
    extraPackages = with pkgs; [
      # Language Servers
      nil                            # ❄️  Nix
      nodePackages.typescript-language-server  # 🟨 TypeScript/JavaScript
      nodePackages.bash-language-server        # 🐚 Bash
      python3Packages.python-lsp-server        # 🐍 Python
      rust-analyzer                  # 🦀 Rust
      clang-tools                    # ⚡ C/C++ (clangd)
      jdt-language-server           # ☕ Java
      nodePackages.intelephense     # 🐘 PHP
      lua-language-server           # 🌙 Lua
      gopls                         # 🐹 Go
      vscode-langservers-extracted  # 🌐 HTML, CSS, JSON language servers
      marksman                      # 📝 Markdown

      # Formatters & Linters
      nixpkgs-fmt                   # Nix formatter
      nodePackages.prettier        # JS/TS/HTML/CSS formatter
      black                         # Python formatter
      rustfmt                       # Rust formatter
      clang-tools                   # C/C++ formatter (clang-format)
      stylua                        # Lua formatter
      shfmt                         # Shell script formatter

      # Tools
      ripgrep                       # Fast text search
      fd                           # Fast file finder
      tree-sitter                  # Parser generator
      git                          # Version control
    ];

    # ╭─────────────────────────────────────────────────────────────────────╮
    # │                      🎛️  NEOVIM CONFIGURATION                      │
    # ╰─────────────────────────────────────────────────────────────────────╯
    extraLuaConfig = ''
      -- ═══════════════════════════════════════════════════════════════════
      --                        🎯 LEADER KEY & BASICS
      -- ═══════════════════════════════════════════════════════════════════
      vim.g.mapleader = " "                    -- Space as leader key
      vim.g.maplocalleader = " "

      -- ═══════════════════════════════════════════════════════════════════
      --                        ⚙️  EDITOR OPTIONS
      -- ═══════════════════════════════════════════════════════════════════
      local opt = vim.opt

      -- Line numbers & navigation
      opt.number = true                        -- Show line numbers
      opt.relativenumber = true               -- Relative line numbers
      opt.cursorline = true                   -- Highlight current line
      opt.scrolloff = 8                       -- Keep 8 lines when scrolling
      opt.sidescrolloff = 8                   -- Keep 8 columns when scrolling

      -- Indentation & formatting
      opt.expandtab = true                    -- Use spaces instead of tabs
      opt.shiftwidth = 2                      -- 2 spaces for indentation
      opt.tabstop = 2                         -- 2 spaces for tab
      opt.softtabstop = 2                     -- 2 spaces for soft tab
      opt.smartindent = true                  -- Smart auto-indentation
      opt.wrap = false                        -- Don't wrap long lines

      -- Search & replace
      opt.hlsearch = false                    -- Don't highlight all matches
      opt.incsearch = true                    -- Incremental search
      opt.ignorecase = true                   -- Ignore case in search
      opt.smartcase = true                    -- Unless uppercase is used

      -- Visual & UI
      opt.termguicolors = true                -- Enable 24-bit RGB colors
      opt.signcolumn = "yes"                  -- Always show sign column
      opt.colorcolumn = "80"                  -- Show column at 80 chars
      opt.conceallevel = 0                    -- Don't hide characters

      -- Behavior
      opt.mouse = "a"                         -- Enable mouse support
      opt.clipboard = "unnamedplus"           -- Use system clipboard
      opt.completeopt = { "menu", "menuone", "noselect" }  -- Completion options
      opt.pumheight = 10                      -- Completion menu height

      -- Files & backup
      opt.backup = false                      -- Don't create backup files
      opt.writebackup = false                 -- Don't backup before overwrite
      opt.swapfile = false                    -- Don't create swap files
      opt.undofile = true                     -- Enable persistent undo

      -- Split behavior
      opt.splitbelow = true                   -- Horizontal splits go below
      opt.splitright = true                   -- Vertical splits go right

      -- ═══════════════════════════════════════════════════════════════════
      --                        🎨 THEME CONFIGURATION
      -- ═══════════════════════════════════════════════════════════════════
      require("gruvbox").setup({
        contrast = "hard",                    -- Hard contrast for better readability
        transparent_mode = false,             -- Solid background
      })
      vim.cmd([[colorscheme gruvbox]])

      -- ═══════════════════════════════════════════════════════════════════
      --                        📊 STATUS LINE (LUALINE)
      -- ═══════════════════════════════════════════════════════════════════
      require('lualine').setup({
        options = {
          theme = 'gruvbox-material',
          component_separators = '|',
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
      })

      -- ═══════════════════════════════════════════════════════════════════
      --                        🌳 FILE TREE (NVIM-TREE)
      -- ═══════════════════════════════════════════════════════════════════
      require("nvim-tree").setup({
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          group_empty = true,
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },
        filters = {
          dotfiles = false,
          custom = { ".git", "node_modules", ".cache" },
        },
        git = {
          enable = true,
          ignore = false,
        },
      })

      -- ═══════════════════════════════════════════════════════════════════
      --                        🔍 TELESCOPE (FUZZY FINDER)
      -- ═══════════════════════════════════════════════════════════════════
      require('telescope').setup({
        defaults = {
          prompt_prefix = "🔍 ",
          selection_caret = "➤ ",
          file_ignore_patterns = {
            "node_modules/", ".git/", "dist/", "build/", "target/", "__pycache__/"
          },
          vimgrep_arguments = {
            'rg', '--color=never', '--no-heading', '--with-filename',
            '--line-number', '--column', '--smart-case'
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
          }
        }
      })
      require('telescope').load_extension('fzf')

      -- ═══════════════════════════════════════════════════════════════════
      --                        🚀 LSP CONFIGURATION
      -- ═══════════════════════════════════════════════════════════════════
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Configure individual language servers
      local servers = {
        nil_ls = {},                          -- Nix
        ts_ls = {},                           -- TypeScript/JavaScript (updated name)
        bashls = {},                          -- Bash
        pylsp = {},                           -- Python
        rust_analyzer = {},                   -- Rust
        clangd = {},                          -- C/C++
        jdtls = {},                           -- Java
        intelephense = {},                    -- PHP
        lua_ls = {                            -- Lua
          settings = {
            Lua = {
              diagnostics = { globals = {'vim'} },
              workspace = { library = vim.api.nvim_get_runtime_file("", true) }
            }
          }
        },
        gopls = {},                           -- Go
        html = {},                            -- HTML
        cssls = {},                           -- CSS
        jsonls = {},                          -- JSON
        marksman = {},                        -- Markdown
      }

      -- Setup each language server
      for server, config in pairs(servers) do
        config.capabilities = capabilities
        lspconfig[server].setup(config)
      end

      -- ═══════════════════════════════════════════════════════════════════
      --                        🔧 COMPLETION (NVIM-CMP)
      -- ═══════════════════════════════════════════════════════════════════
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        })
      })

      -- ═══════════════════════════════════════════════════════════════════
      --                        🔧 GIT INTEGRATION (GITSIGNS)
      -- ═══════════════════════════════════════════════════════════════════
      require('gitsigns').setup({
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol',
          delay = 1000,
        },
      })

      -- ═══════════════════════════════════════════════════════════════════
      --                        💬 COMMENTS & UTILITIES
      -- ═══════════════════════════════════════════════════════════════════
      require('Comment').setup()               -- Smart commenting
      require('nvim-autopairs').setup()        -- Auto pairs
      require('nvim-surround').setup()         -- Surround text objects

      -- ═══════════════════════════════════════════════════════════════════
      --                        ⌨️  KEYBIND MAPPINGS
      -- ═══════════════════════════════════════════════════════════════════
      local keymap = vim.keymap.set

      -- ┌─────────────────────────────────────────────────────────────────┐
      -- │                    🔍 TELESCOPE FUZZY FINDER                    │
      -- └─────────────────────────────────────────────────────────────────┘
      keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = '🔍 Find files' })
      keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = '🔍 Live grep' })
      keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = '🔍 Find buffers' })
      keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = '🔍 Help tags' })
      keymap('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', { desc = '🔍 Recent files' })

      -- ┌─────────────────────────────────────────────────────────────────┐
      -- │                      🌳 FILE TREE NAVIGATION                    │
      -- └─────────────────────────────────────────────────────────────────┘
      keymap('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', { desc = '🌳 Toggle file tree' })
      keymap('n', '<leader>ef', '<cmd>NvimTreeFocus<cr>', { desc = '🌳 Focus file tree' })

      -- ┌─────────────────────────────────────────────────────────────────┐
      -- │                       🔧 GIT OPERATIONS                         │
      -- └─────────────────────────────────────────────────────────────────┘
      keymap('n', '<leader>hs', '<cmd>Gitsigns stage_hunk<cr>', { desc = '🔧 Stage hunk' })
      keymap('n', '<leader>hr', '<cmd>Gitsigns reset_hunk<cr>', { desc = '🔧 Reset hunk' })
      keymap('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<cr>', { desc = '🔧 Preview hunk' })
      keymap('n', '<leader>hb', '<cmd>Gitsigns blame_line<cr>', { desc = '🔧 Blame line' })
      keymap('n', '<leader>gd', '<cmd>DiffviewOpen<cr>', { desc = '🔧 Open diff view' })

      -- ┌─────────────────────────────────────────────────────────────────┐
      -- │                    🚀 LSP (LANGUAGE SERVER)                     │
      -- └─────────────────────────────────────────────────────────────────┘
      keymap('n', 'gd', vim.lsp.buf.definition, { desc = '🚀 Go to definition' })
      keymap('n', 'gr', vim.lsp.buf.references, { desc = '🚀 Find references' })
      keymap('n', 'K', vim.lsp.buf.hover, { desc = '🚀 Hover documentation' })
      keymap('n', '<leader>rn', vim.lsp.buf.rename, { desc = '🚀 Rename symbol' })
      keymap('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '🚀 Code actions' })
      keymap('n', '<leader>f', vim.lsp.buf.format, { desc = '🚀 Format document' })

      -- ┌─────────────────────────────────────────────────────────────────┐
      -- │                    🩺 DIAGNOSTIC NAVIGATION                     │
      -- └─────────────────────────────────────────────────────────────────┘
      keymap('n', '[d', vim.diagnostic.goto_prev, { desc = '🩺 Previous diagnostic' })
      keymap('n', ']d', vim.diagnostic.goto_next, { desc = '🩺 Next diagnostic' })
      keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = '🩺 Diagnostic list' })

      -- ┌─────────────────────────────────────────────────────────────────┐
      -- │                      📄 BUFFER MANAGEMENT                       │
      -- └─────────────────────────────────────────────────────────────────┘
      keymap('n', '<leader>x', '<cmd>bdelete<cr>', { desc = '📄 Close buffer' })
      keymap('n', '<Tab>', '<cmd>bnext<cr>', { desc = '📄 Next buffer' })
      keymap('n', '<S-Tab>', '<cmd>bprevious<cr>', { desc = '📄 Previous buffer' })

      -- ┌─────────────────────────────────────────────────────────────────┐
      -- │                        💾 SAVE & QUIT                          │
      -- └─────────────────────────────────────────────────────────────────┘
      keymap('n', '<leader>w', '<cmd>w<cr>', { desc = '💾 Save file' })
      keymap('n', '<leader>q', '<cmd>q<cr>', { desc = '💾 Quit' })

      -- Clear search highlighting
      keymap('n', '<Esc>', '<cmd>nohlsearch<cr>')
    '';
  };
}
