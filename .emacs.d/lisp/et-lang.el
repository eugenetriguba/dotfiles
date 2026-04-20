;;; et-lang.el --- Language config -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package sly
  :init
  (setq inferior-lisp-program "sbcl"))

(provide 'et-lang)
;;; et-lang.el ends here
