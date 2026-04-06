;;; init.el --- Emacs Configuration entrypoint -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; init.el serves as the entrypoint for this Emacs configuration.
;;
;; The majority of the configuration lives within the lisp/ directory.
;; Each Lisp file is intended to be a self-contained unit for some aspect
;; of my usage of Emacs.  Each file name and definitions within a file
;; are prefixed with et- to namespace them.
;;
;; Because the configuration is generally in these self-contained Lisp
;; files, the primary role of init.el is to bootstrap the loading of these
;; files.
;;
;; Therefore, this entrypoint file:
;; * Sets up the Emacs load path to include the Lisp directory.
;; * Loads each Lisp file in the necessary order.
;;
;;; Code:
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'et-package)
(require 'et-appearance)
(require 'et-vc)
(require 'et-completion)
(require 'et-navigation)
(require 'et-format)
(require 'et-lsp)

;; Misc. grab bag items that aren't formally organized yet.
(setq custom-file (expand-file-name "custom-vars.el" user-emacs-directory))
(when (file-exists-p custom-file)
    (load custom-file))

(setq messages-log-max t)
(setq next-line-add-newlines t)

(use-package project)

(use-package which-key
  :config
  (which-key-mode 1))

(use-package surround
  :bind-keymap ("M-'" . surround-keymap))

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package sly
  :init
  (setq inferior-lisp-program "sbcl"))

(provide 'init)
;;; init.el ends here
