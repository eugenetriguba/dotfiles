;; Setup package.el for installing packages.
;; Use M-x list-packages to see what's available.
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package which-key
  :ensure t
  :config
  (which-key-mode 1))

(use-package nord-theme
  :ensure t
  :config
  (load-theme 'nord t))

(use-package eglot
  :ensure t
  :hook (python-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs '(python-mode . ("ty" "server"))))

(use-package surround
  :ensure t
  :bind-keymap ("M-'" . surround-keymap))

;; Move auto-generated Customize code to custom.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
    (load custom-file))

(menu-bar-mode -1)        ; Remove the menu bar (File Edit Options...)
(tool-bar-mode -1)        ; Remove the tool bar (if using GUI)
(setq inhibit-startup-screen t)  ; Skip the welcome screen

;; Line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

