;; -*- lexical-binding: t; -*-

(use-package eglot
  :hook (python-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs '(python-mode . ("ty" "server"))))

(provide 'et-lsp)
