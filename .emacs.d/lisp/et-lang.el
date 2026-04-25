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

(use-package geiser)
(use-package geiser-guile)

(defun geiser-save ()
  "Save the geiser REPL session."
  (interactive)
  (geiser-repl--write-input-ring))

(provide 'et-lang)
;;; et-lang.el ends here
