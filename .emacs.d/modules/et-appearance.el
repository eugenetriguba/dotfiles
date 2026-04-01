; Remove the menu bar (File Edit Options...)
(menu-bar-mode -1)

; Remove the tool bar (if using the GUI)
(tool-bar-mode -1)

; Skip the welcome screen
(setq inhibit-startup-screen t)

;; Rather than an auditory noise, use a visual
;; flash instead.
(setq visible-bell t)

;; Start emacs in full screen
;;
;; The t parameter appends to the hook, instead of prepending.
;; This means it'll be run after other hooks that might fiddle
;; with the frame size.
(add-hook 'window-setup-hook 'toggle-frame-maximized t)

;; Setup our monospace font
(set-face-attribute 'default nil
		    :font (symbol-value 'et-monospace-font)
		    :height (symbol-value 'et-monospace-font-size))

;; Use line numbers globally
;; (setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

(use-package nord-theme
  :config
  (load-theme 'nord t))

(use-package nerd-icons)
(use-package doom-modeline
  :init (doom-modeline-mode 1))

(provide 'et-appearance)
