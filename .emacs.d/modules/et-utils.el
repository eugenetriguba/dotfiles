;;; et-utils.el --- Utilities for my Emacs configuration -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;;; Code:

(defun et-utils-is-desktop-p ()
  "Check if the current system is my desktop system."
  (string-match-p "desktop" (system-name)))

(provide 'et-utils)
;;; et-utils.el ends here
