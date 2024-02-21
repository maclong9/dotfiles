;;; init.el -*- lexical-binding: t; -*-

(doom! :completion
       company           ; the ultimate code completion backend
       vertico           ; the search engine of the future

       :ui
       deft                ; notational velocity for Emacs
       doom                ; what makes DOOM look the way it does
       doom-dashboard      ; a nifty splash screen for Emacs
       doom-quit           ; DOOM quit-message prompts when you quit Emacs
       (emoji +unicode)    ; 🙂
       indent-guides       ; highlighted indent columns
       (ligatures +extra)  ; ligatures and symbols to make your code pretty again
       modeline            ; snazzy, Atom-inspired modeline, plus API
       nav-flash           ; blink cursor line after big motions
       ophints             ; highlight the region an operation acts on
       (popup +defaults)   ; tame sudden yet inevitable temporary windows
       tabs                ; a tab bar for Emacs
       treemacs            ; a project drawer, like neotree but cooler
       (vc-gutter +pretty) ; vcs diff in the fringe
       window-select       ; visually switch windows
       workspaces          ; tab emulation, persistence & separate workspaces
       zen                 ; distraction-free coding or writing

       :editor
       file-templates      ; auto-snippets for empty files
       fold                ; (nigh) universal code folding
       (format +onsave)    ; automated prettiness
       god                 ; run Emacs commands without modifier keys
       multiple-cursors    ; editing in many places at once
       snippets            ; my elves. They type so I don't have to

       :emacs
       dired               ; making dired pretty [functional]
       electric            ; smarter, keyword-based electric-indent
       undo                ; persistent, smarter undo for your inevitable mistakes
       vc                  ; version-control and Emacs, sitting in a tree

       :term
       vterm               ; the best terminal emulation in Emacs

       :checkers
       syntax              ; tasing you for every semicolon you forget
       (spell +flyspell)   ; tasing you for misspelling mispelling
       grammar             ; tasing grammar mistake every you make

       :tools
       biblio              ; Writes a PhD for you (citation needed)
       debugger            ; FIXME stepping through code, to help you add bug
       dockler
       editorconfig        ; let someone else argue about tabs vs spaces
       ein                 ; tame Jupyter notebooks with emacs
       (eval +overlay)     ; run code, run (also, repls)
       lookup              ; navigate your code and its documentation
       lsp                 ; M-x vscode
       magit               ; a git porcelain for Emacs
       make                ; run make tasks from Emacs
       pdf                 ; pdf enhancements
       prodigy             ; FIXME managing external services & code builders
       rgb                 ; creating color strings
       tree-sitter         ; syntax and parsing, sitting in a tree...

       :os
       (:if (featurep :system 'macos) macos)  ; improve compatibility with macOS
       
       :lang
       (cc +lsp)           ; C > C++ == 1
       elixir              ; erlang done right
       elm                 ; care for a cup of TEA?
       emacs-lisp          ; drown in parentheses
       erlang              ; an elegant language for a more civilized age
       json                ; At least it ain't XML
       javascript          ; all(hope(abandon(ye(who(enter(here))))))
       julia               ; a better, faster MATLAB
       latex               ; writing papers in Emacs has never been so fun
       org                 ; organize your plain life in plain text
       (rust +lsp)         ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       sh                  ; she sells {ba,z,fi}sh shells on the C xor
       swift               ; who asked for emoji variables?
       web                 ; the tubes
       yaml                ; JSON, but readable
       zig                 ; C, but simpler

       :app
       everywhere          ; *leave* Emacs!? You must be joking
       
       :email
       (mu4e +org)         ; You can answer emails in this thing too?
       
       :config
       (default +bindings +smartparens))
