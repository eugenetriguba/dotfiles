;;; et-format.el --- Code formatting configuration ;; -*- lexical-binding: t; -*-
;;; Commentary:
;;
;;; Code:

(use-package flycheck
  :init (global-flycheck-mode))

(setq-default flycheck-emacs-lisp-load-path 'inherit)

(provide 'et-format)
;;; et-format.el ends here
