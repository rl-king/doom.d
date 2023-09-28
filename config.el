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
(setq doom-font (font-spec :family "PragmataPro Mono Liga" :size 17)
      doom-variable-pitch-font (font-spec :family "PragmataPro Mono Liga")
      doom-unicode-font (font-spec :family "PragmataPro Mono Liga")
      doom-big-font (font-spec :family "PragmataPro Mono Liga" :size 22))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tokyo-night)

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
;; FORMAT

(reformatter-define scss-format
  :program "scss-format"
  :args '("--stdin")
  :lighter " SCSSF")

(reformatter-define ormolu-format
  :program "ormolu"
  :args `("-o" "-XOverloadedRecordDot" "-o" "-XTypeApplications" "--stdin-input-file" ,buffer-file-name)
  :group 'ormolu
  :lighter " ORM")

(reformatter-define fourmolu-format
  :program "fourmolu"
  :args `("-o" "-XOverloadedRecordDot" "-o" "-XTypeApplications" "--stdin-input-file" ,buffer-file-name)
  :group 'fourmolu
  :lighter " ORM")

(reformatter-define prettier-format
  :program "prettier"
  :args `("-w" "--stdin-filepath" ,buffer-file-name)
  :group 'prettier
  :lighter " PRTTR")

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (("S-TAB" . 'copilot-accept-completion-by-word)
         ("S-<tab>" . 'copilot-accept-completion-by-word)
         :map copilot-completion-map
         ("<tab>" . 'copilot-accept-completion)
         ("TAB" . 'copilot-accept-completion)))

(add-hook! 'css-mode-hook 'scss-format-on-save-mode)
(add-hook! 'scss-mode-hook 'scss-format-on-save-mode)
(add-hook! 'haskell-mode-hook 'fourmolu-format-on-save-mode)
(add-hook! 'js-mode-hook 'prettier-format-on-save-mode)

(add-hook! 'before-save-hook #'delete-trailing-whitespace)

(setq elm-format-on-save t)

(setq flycheck-navigation-minimum-level 'error)

;; (defun haskellformat ()
;;   (if (string-match-p "itoh" (buffer-file-name))
;;       'fourmolu-format-on-save-mode
;;     'ormolu-format-on-save-mode))

;; (add-hook! 'haskell-mode-hook (haskellformat))

;; NAVIGATION

(setq evil-move-cursor-back nil)
(setq scroll-margin 5)
(setq-default left-fringe-width 18)
(setq-default right-fringe-width 18)
(setq-default evil-escape-key-sequence "fd")
(add-hook! 'prog-mode-hook #'turn-off-smartparens-mode)
(setq-default extra-rg-args "--vimgrep --smart-case")

;; (add-hook! 'prog-mode-hook #'display-fill-column-indicator-mode)

;; (add-to-list 'default-frame-alist '(height . 73))
;; (add-to-list 'default-frame-alist '(width . 140))

;; HASKELL

;; (after! haskell-mode
;;   (set-company-backend! 'haskell-mode '(company-ghci company-etags)))

;; (after! elm-mode
;;   (set-company-backend! 'elm-mode '(company-etags company-dabbrev)))

;; (setq lsp-haskell-server-path "/Users/king/.local/bin/haskell-language-server")
;; (add-hook 'haskell-mode-hook #'flycheck-haskell-setup)

;; (setq haskell-process-path-stack "/usr/local/bin/stack")
;; (defun haskell-mode-setup ()
;;   (setq haskell-process-log t)
;;   (setq haskell-process-type 'stack-ghci))
;; (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
;; (add-hook 'haskell-mode-hook 'haskell-mode-setup)


;; MAGIT

(setq magit-display-buffer-function 'magit-display-buffer-traditional)

(after! magit
  (transient-append-suffix 'magit-push "-u"
    '(1 "-s" "Skip CI pipeline" "--push-option=ci.skip"))
)

;; LSP

(setq-default flycheck-disabled-checkers '(haskell-ghc, haskell-hlint))

;; (setq lsp-auto-configure nil)
;; (setq lsp-modeline-workspace-status-enable nil)
;; (setq lsp-modeline-diagnostics-enable nil)
(setq lsp-ui-sideline-show-diagnostics nil)
(setq lsp-ui-doc-delay 1)
(setq lsp-ui-doc-position 'bottom)
(setq lsp-ui-doc-max-height 20)
(setq lsp-ui-doc-max-width 300)
(setq lsp-lens-enable nil)


;; MISC

(setq confirm-kill-emacs nil)

(defun my/apply-theme (appearance)
  "Load theme, taking current system APPEARANCE into consideration."
  (mapc #'disable-theme custom-enabled-themes)
  (pcase appearance
    ('light (load-theme 'leuven t))
    ('dark (load-theme 'doom-tokyo-night t))))

(add-hook 'ns-system-appearance-change-functions #'my/apply-theme)

(defun elm-compile-dev-null ()
  (interactive "F")
  (elm-compile--file (elm--find-main-file) "/dev/null"))

(setq doom-modeline-height 30)

;; KEYS

(map! :n "SPC TAB" #'evil-switch-to-windows-last-buffer)
(map! :leader :desc "Multi edit" :n "s e" #'evil-multiedit-match-all)
(map! :leader :desc "Multi cursor" :n "s w" #'evil-mc-make-cursor-in-visual-selection-beg)
(map! :n "SPC e n" #'flycheck-next-error)
;; (map! :n "SPC s u" #'counsel-yank-pop)
(map! :n "SPC e N" #'flycheck-previous-error)
(map! :n "SPC c l" #'comment-line)
(map! :v "SPC c l" #'comment-line)
(map! :n "SPC g h" #'hoogle)

(map! :n "C-c c" #'elm-compile-dev-null)
;; (map! :n "C >" #'mc/mark-next-like-this)
