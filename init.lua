vim.opt.list = false
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.clipboard = 'unnamedplus'
vim.keymap.set('n', '<leader>fp', function() print(vim.fn.expand '%:p') end)
vim.g.have_nerd_font = true

vim.opt.termguicolors = true
vim.cmd.hi 'Comment gui=none'
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'Visual', { bg = '#45638f' }) -- selection
vim.api.nvim_set_hl(0, 'Search', { bg = '#222222', fg = '#bbbbbb' })

vim.o.number = true
vim.o.relativenumber = true

vim.o.mouse = 'a'
vim.o.showmode = false

vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Enable break indent
vim.opt.breakindent = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.ai = true
-- Tab stuff
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.lazyredraw = true
vim.opt.ttyfast = true
vim.opt.autoread = true
vim.opt.visualbell = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'
vim.opt.wrap = false
-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.inccommand = 'split'
vim.opt.cursorcolumn = true
vim.o.cursorline = true
vim.api.nvim_set_hl(0, 'CursorLine', { background = '#4d5969' })
vim.api.nvim_set_hl(0, 'CursorColumn', { background = '#4d5969' })

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10
vim.o.confirm = true

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.api.nvim_set_keymap('n', '<S-Down>', '', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Up>', '', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<S-Down>', '', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<S-Up>', '', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<S-Down>', '', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<S-Up>', '', { noremap = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = true, -- Text shows up at the end of the line
  jump = { float = true },
}

-- global
vim.api.nvim_set_keymap('n', '<leader>t', ':NvimTreeToggle<cr>', { silent = true, noremap = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'NvimTree',
  callback = function()
    -- Disable Ctrl+o and Ctrl+i in nvim-tree buffers
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-o>', '<Nop>', opts)
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-i>', '<Nop>', opts)
  end,
})
-- Tab keymaps
vim.api.nvim_set_keymap('n', 'tt', ':tabnew | e#<CR>', { noremap = true, silent = true })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- [[ Install `eazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
require('lazy').setup {
  { 'NMAC427/guess-indent.nvim', opts = {} },
  { 'numToStr/Comment.nvim', opts = {} },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      local harpoon = require 'harpoon'

      harpoon:setup {
        settings = {
          save_on_toggle = true, -- Save state on window toggle
        },
      }

      -- Telescope Config
      local conf = require('telescope.config').values
      local pickers = require 'telescope.pickers'
      local themes = require 'telescope.themes'
      local finders = require 'telescope.finders'
      local actions = require 'telescope.actions'
      local action_state = require 'telescope.actions.state'

      local function generate_new_finder(harpoon_files)
        local files = {}
        for i, item in ipairs(harpoon_files.items) do
          table.insert(files, i .. '. ' .. item.value)
        end

        return finders.new_table {
          results = files,
        }
      end

      -- move_mark_up will move the mark up in the list, refresh the picker's result list and move the selection accordingly
      local function move_mark_up(prompt_bufnr, harpoon_files)
        local selection = action_state.get_selected_entry()
        if not selection then return end
        if selection.index == 1 then return end

        local mark = harpoon_files.items[selection.index]

        table.remove(harpoon_files.items, selection.index)
        table.insert(harpoon_files.items, selection.index - 1, mark)

        local current_picker = action_state.get_current_picker(prompt_bufnr)
        current_picker:refresh(generate_new_finder(harpoon_files), {})

        -- yes defer_fn is an awful solution. If you find a better one, please let the world know.
        -- it's used here because we need to wait for the picker to refresh before we can set the selection
        -- actions.move_selection_previous() doesn't work here because the selection gets reset to 0 on every refresh.
        vim.defer_fn(function()
          -- don't even bother finding out why this is -2 here. (i don't know either)
          current_picker:set_selection(selection.index - 2)
        end, 2) -- 2ms was the minimum delay I could find that worked without glitching out the picker
      end

      -- move_mark_down will move the mark down in the list, refresh the picker's result list and move the selection accordingly
      local function move_mark_down(prompt_bufnr, harpoon_files)
        local selection = action_state.get_selected_entry()
        if not selection then return end

        local length = harpoon:list():length()
        if selection.index == length then return end

        local mark = harpoon_files.items[selection.index]

        table.remove(harpoon_files.items, selection.index)
        table.insert(harpoon_files.items, selection.index + 1, mark)

        local current_picker = action_state.get_current_picker(prompt_bufnr)
        current_picker:refresh(generate_new_finder(harpoon_files), {})

        -- yes defer_fn is an awful solution. If you find a better one, please let the world know.
        -- it's used here because we need to wait for the picker to refresh before we can set the selection
        -- actions.move_selection_next() doesn't work here because the selection gets reset to 0 on every refresh.
        vim.defer_fn(function() current_picker:set_selection(selection.index) end, 2) -- 2ms was the minimum delay I could find that worked without glitching out the picker
      end

      local function toggle_telescope(harpoon_files)
        pickers
          .new(
            themes.get_dropdown {
              --TODO: make previewer work.
              previewer = false,
            },
            {
              prompt_title = 'Harpoon',
              finder = generate_new_finder(harpoon_files),
              previewer = conf.file_previewer {},
              sorter = conf.generic_sorter {},
              -- Initial mode, change this to your liking. Normal mode is better for navigating with j/k
              initial_mode = 'normal',
              -- Make telescope select buffer from harpoon list
              attach_mappings = function(_, map)
                actions.select_default:replace(function(prompt_bufnr)
                  local curr_entry = action_state.get_selected_entry()
                  if not curr_entry then return end
                  actions.close(prompt_bufnr)

                  harpoon:list():select(curr_entry.index)
                end)
                -- Delete entries in insert mode from harpoon list with <C-d>
                -- Change the keybinding to your liking
                map({ 'n', 'i' }, '<C-d>', function(prompt_bufnr)
                  local curr_picker = action_state.get_current_picker(prompt_bufnr)

                  curr_picker:delete_selection(function(selection) harpoon:list():remove_at(selection.index) end)
                end)
                -- Move entries up and down with <C-j> and <C-k>
                -- Change the keybinding to your liking
                map({ 'n', 'i' }, '<C-j>', function(prompt_bufnr) move_mark_down(prompt_bufnr, harpoon_files) end)
                map({ 'n', 'i' }, '<C-k>', function(prompt_bufnr) move_mark_up(prompt_bufnr, harpoon_files) end)

                return true
              end,
            }
          )
          :find()
      end

      -- Telescope Harpoon List
      vim.keymap.set('n', '<leader>h', function() toggle_telescope(harpoon:list()) end, { desc = 'List Harpoon Files (Telescope)' })

      -- Append to Harpoon List
      vim.keymap.set('n', '<leader>af', function() harpoon:list():add() end, { desc = 'Append File to Harpoon' })

      -- Go to Previous Harpoon File
      vim.keymap.set('n', '<leader>j', function() harpoon:list():prev { ui_nav_wrap = true } end, { desc = 'Previous Harpoon File' })

      -- Go to Next Harpoon File
      vim.keymap.set('n', '<leader>k', function() harpoon:list():next { ui_nav_wrap = true } end, { desc = 'Next Harpoon File' })

      -- Clear harpoon List
      vim.keymap.set('n', '<leader>ac', function() harpoon:list():clear() end, { desc = 'Clear Harpoon List' })

      -- Select Harpoon File from List (1-5)
      for i = 1, 5 do
        vim.keymap.set('n', string.format('<C-%s>', i), function() harpoon:list():select(i) end)
      end
    end,
  },
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      current_line_blame = true,
    },
    config = function(_, opts)
      require('gitsigns').setup(opts)

      -- change blame text color
      vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', {
        fg = '#a8a8a8',
      })
    end,
  },
  {
    'folke/which-key.nvim',
    event = 'VimEnter', -- load on startup
    opts = {
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },
    },
    config = function(_, opts)
      local ok, wk = pcall(require, 'which-key')
      if not ok then
        vim.notify('which-key not found!', vim.log.levels.WARN)
        return
      end

      wk.setup(opts)

      -- Add your key groups after setup
      wk.register({
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>c', group = '[C]ode' },
      }, { mode = 'n' }) -- normal mode
    end,
  },
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    branch = 'master',
    enabled = true,
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function() return vim.fn.executable 'make' == 1 end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-telescope/telescope-live-grep-args.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = { require('telescope.themes').get_dropdown() },
        },
      }
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'live_grep_args')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', function() require('telescope').extensions.live_grep_args.live_grep_args() end, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- This runs on LSP attach per buffer (see main LSP attach function in 'neovim/nvim-lspconfig' config for more info,
      -- it is better explained there). This allows easily switching between pickers if you prefer using something else!
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
        callback = function(event)
          local buf = event.buf

          -- Find references for the word under your cursor.
          vim.keymap.set('n', 'gr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })

          -- Jump to the implementation of the word under your cursor.
          -- Useful when your language has ways of declaring types without an actual implementation.
          vim.keymap.set('n', 'gi', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })

          -- Jump to the definition of the word under your cursor.
          -- This is where a variable was first declared, or where a function is defined, etc.
          -- To jump back, press <C-t>.
          vim.keymap.set('n', 'gd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })

          -- Fuzzy find all the symbols in your current document.
          -- Symbols are things like variables, functions, types, etc.
          vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })

          -- Fuzzy find all the symbols in your current workspace.
          -- Similar to document symbols, except searches over your entire project.
          vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })

          -- Jump to the type of the word under your cursor.
          -- Useful when you're not sure what type a variable is and you want to see
          -- the definition of its *type*, not where it was *defined*.
          vim.keymap.set('n', 'gt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })
        end,
      })

      -- Override default behavior and theme when searching
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set(
        'n',
        '<leader>s/',
        function()
          builtin.live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          }
        end,
        { desc = '[S]earch [/] in Open Files' }
      )

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- LSP Plugins
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true, opts = { ensure_installed = { 'graphql-language-service-cli' } } }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'mason-org/mason.nvim', opts = {} },
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method('textDocument/documentHighlight', event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end
          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client:supports_method('textDocument/inlayHint', event.buf) then
            map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local servers = {
        -- clangd = {},
        buf_ls = {},
        graphql = {
          root_dir = require('lspconfig').util.root_pattern '.graphqlrc.yaml',
          capabilities = capabilities,
          filetypes = { 'graphql', 'go', 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
        },
        jdtls = {},
        jsonls = {},
        ts_ls = {},
        --

        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'lua_ls', -- Lua Language server
        'stylua', -- Used to format Lua code
        -- You can add other tools here that you want Mason to install
      })

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      for name, server in pairs(servers) do
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        vim.lsp.config(name, server)
        vim.lsp.enable(name)
      end

      -- Special Lua Config, as recommended by neovim help docs
      vim.lsp.config('lua_ls', {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT',
              path = { 'lua/?.lua', 'lua/?/init.lua' },
            },
            workspace = {
              checkThirdParty = false,
              -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
              --  See https://github.com/neovim/nvim-lspconfig/issues/3189
              library = vim.api.nvim_get_runtime_file('', true),
            },
          })
        end,
        settings = {
          Lua = {},
        },
      })
      vim.lsp.enable 'lua_ls'
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function() require('conform').format { async = true, lsp_format = 'fallback' } end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
        javascript = { 'prettier' },
        json = { 'prettier' },
      },
      formatters = {
        prettier = {
          -- Use local node_modules prettier
          command = 'node_modules/.bin/prettier',
          -- Don't pass config args - let prettier find .prettierrc
          args = { '--stdin-filepath', '$FILENAME' },
        },
      },
    },
  },

  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then return end
          return 'make install_jsregexp'
        end)(),
        dependencies = {},
        opts = {},
      },
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'default',
      },
      appearance = {
        nerd_font_variant = 'mono',
      },
      completion = {
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets' },
      },
      snippets = { preset = 'luasnip' },
      fuzzy = { implementation = 'lua' },
      signature = { enabled = true },
    },
  },

  {
    'loctvl842/monokai-pro.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    opts = {
      styles = {
        keywords = { italic = false },
        functions = { italic = false },
        variables = { italic = false },
        sidebars = 'transparent',
        floats = 'transparent',
      },
    },
    init = function()
      require('monokai-pro').setup {
        filter = 'spectrum',
        styles = {
          comment = { italic = false },
          keyword = { italic = false },
          type = { italic = false },
          storageclass = { italic = false },
          structure = { italic = false },
          parameter = { italic = false },
          annotation = { italic = false },
          tag_attribute = { italic = false },
        },
      }
      vim.cmd.colorscheme 'monokai-pro'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = false,
      colors = {
        error = { '#ff5555' }, -- FIXME
        warning = { '#f7c077' }, -- WARNING
        info = { '#fdffc4' }, -- TODO
        hint = { '#c4e8ff' }, -- HINT
        default = { '#bd93f9' },
        test = { '#ff79c6' },
      },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
  },
  { -- Collection of various small independent plugins/modules
    'nvim-mini/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function() return '%2l:%-2v' end

      -- ... and there is more!
      --  Check out: https://github.com/nvim-mini/mini.nvim
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {
        filters = {
          dotfiles = false,
        },
        git = {
          ignore = false,
        },
      }
    end,
  },
  {
    'nvim-web-devicons',
    config = function() require('nvim-web-devicons').setup {} end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    config = function()
      local filetypes = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
      require('nvim-treesitter').install(filetypes)
      vim.api.nvim_create_autocmd('FileType', {
        pattern = filetypes,
        callback = function() vim.treesitter.start() end,
      })
    end,
  },

  require 'kickstart.plugins.autopairs',
}
