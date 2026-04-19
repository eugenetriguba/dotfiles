;;; et-vi.el --- Vi keybindings -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(provide 'et-vi)
;;; et-vi.el ends here
