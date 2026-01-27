(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump t)

  :config
  (evil-mode 1))

(use-package which-key
  :ensure t
  :config
  (which-key-mode 1))

(use-package xclip
  :ensure t
  :config
  (xclip-mode 1))

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-tokyo-night t))

;; Move auto-generated Customize code to custom.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
    (load custom-file))

(use-package dumb-jump
  :ensure t
  :config
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

(menu-bar-mode -1)        ; Remove the menu bar (File Edit Options...)
(tool-bar-mode -1)        ; Remove the tool bar (if using GUI)
(setq inhibit-startup-screen t)  ; Skip the welcome screen

;; Line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)
