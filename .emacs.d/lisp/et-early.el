;;; et-early.el --- Early init configuration -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'et-utils)

;; Temporarily increase GC threshold during startup
(setq gc-cons-threshold most-positive-fixnum)

;; Restore to normal value after startup (e.g. 100MB)
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 100 1024 1024))))

(defvar et-monospace-font "Hack Nerd Font Mono"
  "The font used by default and for any monospaced font usage.")
(defvar et-monospace-font-size (if (et-is-desktop-p) 192 160))
(set-face-attribute 'default nil
		    :font (symbol-value 'et-monospace-font)
		    :height (symbol-value 'et-monospace-font-size))

;; Start emacs in full screen
;;
;; The t parameter appends to the hook, instead of prepending.
;; This means it'll be run after other hooks that might fiddle
;; with the frame size.
(add-hook 'window-setup-hook 'toggle-frame-maximized t)

;; Remove the menu bar (File Edit Options...)
(menu-bar-mode -1)

;; Remove the tool bar (if using the GUI)
(tool-bar-mode -1)

;; Skip the welcome screen
(setq inhibit-startup-screen t)

;; Turn off the bell
(setq visible-bell nil
      ring-bell-function #'ignore)

(setq messages-log-max t)
(setq next-line-add-newlines t)

(provide 'et-early)
;;; et-early.el ends here
