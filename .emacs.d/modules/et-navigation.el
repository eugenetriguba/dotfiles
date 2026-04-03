;;; et-navigation.el --- Emacs navigation utiltiies -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;; This module overrides the "scroll up page" and "scroll down page"
;; default Emacs key mappings to only scroll up and down half a page.
;;
;;; Code:

(global-set-key (kbd "C-v")
                'et-scroll-down-half-page)

(global-set-key (kbd "M-v")
                'et-scroll-up-half-page)

(defun et-scroll-down-half-page ()
  "Scroll down half a page while keeping the cursor centered."
  (interactive)
  (let ((ln (line-number-at-pos))
	(lmax (line-number-at-pos (point-max))))
    (cond ((= ln 1) (move-to-window-line nil))
	  ((= ln lmax) (recenter (window-end)))
	  (t (progn
               (move-to-window-line -1)
               (recenter))))))

(defun et-scroll-up-half-page ()
  "Scroll up half a page while keeping the cursor centered."
  (interactive)
  (let ((ln (line-number-at-pos))
	(lmax (line-number-at-pos (point-max))))
    (cond ((= ln 1) nil)
	  ((= ln lmax) (move-to-window-line nil))
	  (t (progn
               (move-to-window-line 0)
               (recenter))))))

(provide 'et-navigation)
;;; et-navigation.el ends here
