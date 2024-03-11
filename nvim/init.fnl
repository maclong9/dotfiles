(require-macros :hibiscus.core)
(require-macros :hibiscus.vim)

;; TODO: Status Line (mode_block = [n: blue, i: pink, v: green)
;;       left: mode_block, lsp_diagnostics
;;       center: file_name
;;       right: breadcrums, mode_block
;;
;; TODO: Figure out how to disable virtual_text without neovim complaining on startup
;;
;; TODO: Setup LaTeX wiht VimTex and Zathura

;; Options
(g! mapleader " ")
(set! tabstop 2)
(set! shiftwidth 2)
(set! background :dark)
(set! scl :no)
(each [_ opt (ipairs [
        "relativenumber"
        "hlsearch"
        "cindent"
        "incsearch"
        "ignorecase"
        "smartcase"
        "linebreak"
        "expandtab"
      ])]
  (set! opt true))
(vim.diagnostic.config {:virtual_text true})

;; Plugins
((. (require :lazy) :setup) [
  :nyoom-engineering/oxocarbon.nvim
  :nvim-lua/plenary.nvim
  :tpope/vim-fugitive

  ;; Fennel
  { 1
    :udayvir-singh/hibiscus.nvim
  }
  { 1
    :udayvir-singh/tangerine.nvim
  }

  ;; LSP
  { 1
    :neovim/nvim-lspconfig
    :keys [
      { 1 :<leader>ld 2 vim.diagnostic.open_float :desc "Open diagnostic window" }
    ]
  }
  { 1
    :sigmasd/deno-nvim
    :opts (fn []
      ((. (require :deno-nvim) :setup) {})	
    )
  }

  ;; Motion
  { 1
    :chrisgrieser/nvim-spider
    :keys [
      { 1 :w 2 "<cmd>lua require('spider').motion('w')<cr>" :mode [:n :o :x] }
      { 1 :e 2 "<cmd>lua require('spider').motion('e')<cr>" :mode [:n :o :x] }
      { 1 :b 2 "<cmd>lua require('spider').motion('b')<cr>" :mode [:n :o :x] }
    ]
  }

  ;; Indent
  { 1
    :echasnovski/mini.indentscope
    :opts {
      :options {
        :try_as_border true
      }
      :symbol "│"
    }
  }
  { 1
    :lukas-reineke/indent-blankline.nvim
    :main :ibl
    :opts {}
  }

  ;; Editor
  { 1
    :nvim-telescope/telescope.nvim
    :keys [
      { 1 :<leader>ff 2 "<cmd>Telescope find_files<cr>" :desc "Find files" }
      { 1 :<leader>fs 2 "<cmd>Telescope lsp_document_symbols<cr>" :desc "Find symbols" }
      { 1 :<leader>fk 2 "<cmd>Telescope keymaps<cr>" :desc "Find keymaps"}
      { 1 :<leader>fd 2 "<cmd>Telescope diagnostics<cr>" :desc "Find keymaps"}
    ]
  }
  { 1
    :stevearc/oil.nvim
    :keys [
      { 1 :<leader>e 2 "<cmd>Oil<cr>" :desc "Open file explorer" }
    ]
    :opts {
      :default_file_explorer true
      :columns [
        "icon"
      ]
    }
  }
])

(color! :oxocarbon)
