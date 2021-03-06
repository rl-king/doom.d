;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "PragmataPro Mono Liga" :size 17))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'leuven)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; LIGATURES

(add-load-path! "~/Private/temp/emacs-pragmatapro-ligatures")
(require 'pragmatapro-lig)

(add-hook 'haskell-mode-hook 'pragmatapro-lig-mode)
(add-hook 'elm-mode-hook 'pragmatapro-lig-mode)


;; FORMAT

(reformatter-define scss-format
  :program "scss-format"
  :args '("--stdin")
  :lighter " SCSSF")

(reformatter-define ormolu-format
  :program "ormolu"
  :args '("--ghc-opt" "-XTypeApplications" "/dev/stdin")
  :group 'ormolu
  :lighter " ORM")

(add-hook 'css-mode-hook 'scss-format-on-save-mode)
(add-hook 'scss-mode-hook 'scss-format-on-save-mode)
(add-hook 'haskell-mode-hook 'ormolu-format-on-save-mode)
(add-hook 'before-save-hook #'delete-trailing-whitespace)
(setq elm-format-on-save t)


;; NAVIGATION

(setq evil-move-cursor-back nil)
(setq scroll-margin 15)
(setq-default left-fringe-width 18)
(setq-default right-fringe-width 18)
(setq-default evil-escape-key-sequence "fd")
(add-hook 'prog-mode-hook #'turn-off-smartparens-mode)

(setq-default  extra-rg-args "--vimgrep --smart-case")

;; HASKELL

(add-hook 'haskell-mode-hook #'flycheck-haskell-setup)
;; (setq haskell-process-path-stack "/usr/local/bin/stack")
;; (defun haskell-mode-setup ()
;;   (setq haskell-process-log t)
;;   (setq haskell-process-type 'stack-ghci))
;; (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
;; (add-hook 'haskell-mode-hook 'haskell-mode-setup)


;; ERLANG

(setq flycheck-erlang-include-path
      '("/Users/king/Driebit/zotonic/include"
        "/Users/king/Driebit/zotonic/deps"
        "/Users/king/Driebit/zotonic"
        "/Users/king/Driebit/ginger/modules"))


;; MAGIT

(setq magit-display-buffer-function 'magit-display-buffer-traditional)


;; LSP

;; (setq lsp-ui-sideline-show-diagnostics nil)


;; KEYS

(map! :n "SPC TAB" #'evil-switch-to-windows-last-buffer)
(map! :n "SPC s e" #'evil-multiedit-match-all)
(map! :v "SPC s e" #'evil-multiedit-match-all)
(map! :n "SPC e n" #'flycheck-next-error)
(map! :n "SPC e N" #'flycheck-previous-error)
(map! :n "SPC c l" #'comment-line)
(map! :v "SPC c l" #'comment-line)

;; MISC
(setq confirm-kill-emacs nil)


;; ;; GOLDEN RATIO MODE
;; ;; https://github.com/hlissner/doom-emacs/issues/2225
;; ;;
;; (use-package! golden-ratio
;;   :after-call pre-command-hook
;;   :config
;;   (golden-ratio-mode +1)
;;   ;; Using this hook for resizing windows is less precise than
;;   ;; `doom-switch-window-hook'.
;;   (remove-hook 'window-configuration-change-hook #'golden-ratio)
;;   (add-hook 'doom-switch-window-hook #'golden-ratio))
