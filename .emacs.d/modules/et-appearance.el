;;; et-appearance --- Configuration for the "Look" of Emacs -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;;; Code:
(require 'et-utils)

(defvar et-monospace-font "Hack Nerd Font Mono"
  "The font used by default and for any monospaced font usage.")
(defvar et-monospace-font-size (if (et-utils-is-desktop-p) 192 160))
(set-face-attribute 'default nil
		    :font (symbol-value 'et-monospace-font)
		    :height (symbol-value 'et-monospace-font-size))

;; Start emacs in full screen
;;
;; The t parameter appends to the hook, instead of prepending.
;; This means it'll be run after other hooks that might fiddle
;; with the frame size.
(add-hook 'window-setup-hook 'toggle-frame-maximized t)

; Remove the menu bar (File Edit Options...)
(menu-bar-mode -1)

; Remove the tool bar (if using the GUI)
(tool-bar-mode -1)

; Skip the welcome screen
(setq inhibit-startup-screen t)

;; Rather than an auditory noise, use a visual
;; flash instead.
(setq visible-bell t)

;; Default to using line numbers in all modes
;; and turn them off one by one in the particular
;; modes where they don't make as much sense.
(global-display-line-numbers-mode 1)
(dolist (mode '(text-mode-hook
		org-mode-hook
		term-mode-hook
		eshell-mode-hook
		shell-mode-hook
		special-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package nord-theme
  :config
  (load-theme 'nord t))

(use-package nerd-icons)
(use-package doom-modeline
  :init (doom-modeline-mode 1))

(provide 'et-appearance)
;;; et-appearance.el ends here
