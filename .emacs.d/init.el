;; -*- lexical-binding: t; -*-

;; Add configuration modules to load path
(add-to-list 'load-path '"~/.dotfiles/.emacs.d/modules")

;; --------- Core Utilities ---------------------
(defun et-is-desktop-p ()
  (string-match-p "desktop" (system-name)))

;; --------- Core Variables ---------------------
(defvar et-monospace-font "Hack Nerd Font Mono"
  "The font used by default and for any monospaced font usage.")
(defvar et-monospace-font-size (if (et-is-desktop-p) 192 160))

;; --------- Modules ----------------------------
(require 'et-package)
(require 'et-appearance)
(require 'et-vc)
(require 'et-completion)
(require 'et-lsp)

(use-package which-key
  :config
  (which-key-mode 1))

(use-package surround
  :bind-keymap ("M-'" . surround-keymap))

(setq custom-file (expand-file-name "custom-vars.el" user-emacs-directory))
(when (file-exists-p custom-file)
    (load custom-file))

(setq messages-log-max t)
