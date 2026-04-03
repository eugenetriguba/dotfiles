;;; et-lsp.el --- Setup LSP servers for necessary languages -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;;; Code:

(use-package eglot
  :hook (python-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs '(python-mode . ("ty" "server"))))

(provide 'et-lsp)
;;; et-lsp.el ends here
