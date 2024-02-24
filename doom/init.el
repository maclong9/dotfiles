;;; init.el -*- lexical-binding: t; -*-tt

(doom!
 :completion
 (company +childframe)            ; the ultimate code completion backend
 (vertico +childframe +icons)     ; the search engine of there future

 :ui
 doom                             ; what makes DOOM look the way it does
 doom-dashboard                   ; a nifty splash screen for Emacs
 doom-quit                        ; DOOM quit-message prompts when you quit Emacs
 (emoji +github +unicode)         ; 🙂
 hl-todo                          ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
 indent-guides                    ; highlighted indent columns
 (ligatures +extra)               ; ligatures and symbols to make your code pretty again
 modeline                         ; snazzy, Atom-inspired modeline, plus API
 nav-flash                        ; blink cursor line after big motions
 ophints                          ; highlight the region an operation acts on
 (popup +defaults)                ; tame sudden yet inevitable temporary windowst
 tabs                             ; a tab bar for Emacs
 (treemacs +lsp)                  ; a project drawer, like neotree but cooler
 unicode                          ; extended unicode support for various languages
 (vc-gutter +pretty)              ; vcs diff in the fringe
 vi-tilde-fringe                  ; fringe tildes to mark beyond EOB
 workspaces                       ; tab emulation, persistence & separate workspaces

 :editor
 file-templates                   ; auto-snippets for empty files
 fold                             ; (ignh) universal code folding
 (format +onsave)                 ; automated prettiness
 multiple-cursors                 ; editing in many places at once
 objed                            ; text object editing for the innocent
 snippets                         ; my elves. They type so I don't have to

 :emacs
 (dired +icons)                   ; making dired pretty [functional]
 electric                         ; smarter, keyword-based electric-indent
 undo                             ; persistent, smarter undo for your inevitable mistakes
 vc                               ; version-control and Emacs, sitting in a tree

 :term
 vterm                            ; the best terminal emulation in Emacs

 :checkers
 (syntax +childframe)             ; tasing you for every semicolon you forget
 (spell +flyspell)                ; tasing you for misspelling mispelling
 grammar                          ; tasing grammar mistake every you make

 :tools
 biblio                           ; Writes a PhD for you (citation needed)
 (debugger +lsp)                  ; FIXME stepping through code, to help you add bugs
 editorconfig                     ; let someone else argue about tabs vs spaces
 (eval +overlay)                  ; run code, run (also, repls)
 (lookup +dictionary)             ; navigate your code and its documentation
 (lsp +peek)                      ; M-x vscode
 (magit +forge)                   ; a git porcelain for Emacs
 make                             ; run make tasks from Emacs
 rgb                              ; creating color strings
 taskrunner                       ; taskrunner for all your projects
 tree-sitter                      ; syntax and parsing, sitting in a tree...

 :lang
 (cc +lsp)                       ; C > C++ == 1
 (elixir +lsp)                   ; erlang done right
 (elm +lsp)                      ; care for a cup of TEA?
 emacs-lisp                      ; drown in parentheses
 (json +lsp)                     ; At least it ain't XML
 (javascript +lsp)               ; all(hope(abandon(ye(who(enter(here))))))
 (julia +lsp)                    ; a better, faster MATLAB
 (latex +latexmk +cdlatex +lsp)  ; writing papers in Emacs has never been so fun
 org                             ; organize your plain life in plain text
 (rust +lsp)                     ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
 (sh +lsp)                       ; she sells {ba,z,fi}sh shells on the C xor
 (web +lsp)                      ; the tubes
 (yaml +lsp)                     ; JSON, but readable
 (zig +lsp)                      ; C, but simpler

 :os
 (:if (featurep :system 'macos) macos)

 :config
 (default +bindings +smartparens))
