;;; et-vi.el --- Vi keybindings -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-undo-system 'undo-redo)
  (evil-mode 1))

(use-package evil-collection
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-commentary
  :ensure t
  :config
  (evil-commentary-mode))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(provide 'et-vi)
;;; et-vi.el ends here
