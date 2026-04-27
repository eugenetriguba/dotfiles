;;; et-format.el --- Code formatting configuration ;; -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(setq-default flycheck-emacs-lisp-load-path 'inherit)

(use-package apheleia
  :ensure t
  :config
  (apheleia-global-mode +1))

(provide 'et-format)
;;; et-format.el ends here
