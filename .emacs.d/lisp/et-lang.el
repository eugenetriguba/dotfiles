;;; et-lang.el --- Language config -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package sly
  :ensure t
  :init
  (setq inferior-lisp-program "sbcl"))

(use-package geiser
  :pin "melpa"
  :ensure t)

(use-package geiser-guile
  :pin "melpa"
  :ensure t)

(provide 'et-lang)
;;; et-lang.el ends here
