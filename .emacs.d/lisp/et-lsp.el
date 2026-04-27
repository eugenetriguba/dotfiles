;;; et-lsp.el --- Setup LSP servers for necessary languages -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package eglot
  :ensure t
  :hook ((python-mode . eglot-ensure)
	 (go-mode . eglot-ensure))
  :init
  (setq eglot-prefer-plaintext t)
  :config
  (add-to-list 'eglot-server-programs '(python-mode . ("ty" "server"))))

(provide 'et-lsp)
;;; et-lsp.el ends here
