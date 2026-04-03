;;; et-utils.el --- Utilities for my Emacs configuration -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;;; Code:

(defun et-is-desktop-p ()
  "Check if the current system is my desktop system."
  (string-match-p "desktop" (system-name)))

(defun et-insert-elisp-template (summary)
  "Insert a elisp template into the buffer.

SUMMARY will be inserted into the header docstring
as the file summary."
  (interactive (list (read-string "summary: ")))
  (let ((move-to-center-of-code-section (lambda () (forward-line -3)))
	(get-current-file-name (lambda () (file-name-sans-extension (file-name-nondirectory buffer-file-name))))
	(get-module-template (lambda (module-name summary)
			       (format ";;; %s.el --- %s -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;;; Code:



(provide '%s)
;;; %s.el ends here" module-name summary module-name module-name))))
    (if (not (buffer-file-name))
	(message "No file visited.")
      (progn
	(insert (funcall get-module-template (funcall get-current-file-name) summary))
	(funcall move-to-center-of-code-section)))))

(provide 'et-utils)
;;; et-utils.el ends here
