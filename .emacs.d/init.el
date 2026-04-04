;;; init.el --- Emacs Configuration entrypoint -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; init.el serves as the entrypoint for this Emacs configuration.
;;
;; The majority of the configuration lives within the modules/
;; directory.  Each module is intended to be a self-contained unit for
;; some aspect of my usage of Emacs.  Each module name and definitions
;; within a module is prefixed with et- to namespace them.
;;
;; Because the configuration is generally in these module files, the
;; primary role of init.el is to bootstrap the loading of these
;; modules.
;;
;; Therefore, this entrypoint file:
;; * Sets up the Emacs load path to include the modules directory.
;; * Loads each module in the necessary order.
;;
;;; Code:
(add-to-list 'load-path "~/.emacs.d/vendor")
(require 'find-file-in-project)
(setq ffip-use-rust-fd t)
(global-set-key (kbd "C-c p f") 'find-file-in-project)
(global-set-key (kbd "C-c p s") 'find-file-in-project-by-selected)

(add-to-list 'load-path "~/.emacs.d/modules")
(require 'et-package)
(require 'et-appearance)
(require 'et-vc)
(require 'et-completion)
(require 'et-navigation)
(require 'et-format)
(require 'et-lsp)

;; Misc. grab bag items that aren't formally organized yet.
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

(setq custom-file (expand-file-name "custom-vars.el" user-emacs-directory))
(when (file-exists-p custom-file)
    (load custom-file))

(setq messages-log-max t)

(provide 'init)
;;; init.el ends here
