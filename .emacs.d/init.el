;; Add configuration modules to load path
(add-to-list 'load-path '"~/.dotfiles/.emacs.d/modules")

;; --------- Core Variables ---------------------
(defvar et/monospace-font "Hack Nerd Font Mono"
  "The font used by default and for any monospaced font usage.")
(defvar et/monospace-font-size 128)

;; --------- Modules ----------------------------
(require 'et-package)
(require 'et-appearance)
(require 'et-vc)

(use-package which-key
  :config
  (which-key-mode 1))


(use-package eglot
  :hook (python-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs '(python-mode . ("ty" "server"))))

(use-package surround
  :bind-keymap ("M-'" . surround-keymap))

(use-package vertico
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package savehist
  :init
  (savehist-mode))

(use-package marginalia
  :after vertico
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(setq custom-file (expand-file-name "custom-vars.el" user-emacs-directory))
(when (file-exists-p custom-file)
    (load custom-file))

(setq messages-log-max t)
