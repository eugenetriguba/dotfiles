;;; et-tidy.el --- Tidy up emacs -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package no-littering
  :config
  (setq auto-save-file-name-transforms
	`((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
  (setq backup-directory-alist
	`(("." . ,(no-littering-expand-var-file-name "backup/"))))
  (setq custom-file
	(expand-file-name "custom-vars.el" no-littering-etc-directory))
  (when (file-exists-p custom-file)
    (load custom-file)))

(provide 'et-tidy)
;;; et-tidy.el ends here
