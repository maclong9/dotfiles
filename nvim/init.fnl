(require-macros :hibiscus.core)
(require-macros :hibiscus.vim)

;; Options
(set! tabstop 2)
(set! shiftwidth 2)
(each [_ opt (ipairs [
        "relativenumber"
        "hlsearch"
        "incsearch"
        "ignorecase"
        "smartcase"
        "linebreak"
        "expandtab"
      ])]
  (set! opt true)
)

;; Variables
(g! mapleader " ")

;; Plugins
((. (require :lazy) :setup) [
  { 1
    :chrisgrieser/nvim-spider 
    :lazy true 
    :keys [
      { 1 :w 2 "<cmd>lua require('spider').motion('w')<cr>" :mode [:n :o :x] }
      { 1 :e 2 "<cmd>lua require('spider').motion('e')<cr>" :mode [:n :o :x] }
      { 1 :b 2 "<cmd>lua require('spider').motion('b')<cr>" :mode [:n :o :x] }
    ]
  }
  :echasnovski/mini.indentscope
  :goolord/alpha-nvim
  { 1
    :lukas-reineke/indent-blankline.nvim
    :main :ibl
    :opts {}
  }
  :nvim-lua/plenary.nvim
  :nvim-telescope/telescope.nvim
  :nyoom-engineering/oxocarbon.nvim
  :rebelot/heirline.nvim
  :stevearc/oil.nvim
  :udayvir-singh/hibiscus.nvim
  :udayvir-singh/tangerine.nvim
])

;; Configuration
(color! :oxocarbon)

