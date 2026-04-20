;;; et-vi.el --- Vi keybindings -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-undo-system 'undo-redo)
  (evil-mode 1))

(use-package evil-collection
  :config
  (evil-collection-init))

(use-package evil-commentary
  :config
  (evil-commentary-mode))

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

(provide 'et-vi)
;;; et-vi.el ends here
