;;; et-appearance --- Configuration for the "Look" of Emacs -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'et-utils)

;; Default to using line numbers in all modes
;; and turn them off one by one in the particular
;; modes where they don't make as much sense.
(global-display-line-numbers-mode 1)
(dolist (mode '(text-mode-hook
		man-mode-hook
		org-mode-hook
		term-mode-hook
		eshell-mode-hook
		shell-mode-hook
		special-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Use relative line numbers since they are nice when using vim
;; keybindings with evil mode.
(setq display-line-numbers-type 'relative)

;; Set the emacs frame title to the full file path.
;;
;; Source - https://stackoverflow.com/a/3669681
;; Posted by Jérôme Radix, modified by community. See post 'Timeline' for change history
;; Retrieved 2026-04-25, License - CC BY-SA 3.0
(setq frame-title-format
      (list (format "%s %%S: %%j " (system-name))
            '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

(use-package nord-theme
  :config
  (load-theme 'nord t))

(use-package nerd-icons)
(use-package doom-modeline
  :init (doom-modeline-mode 1))

(provide 'et-appearance)
;;; et-appearance.el ends here
