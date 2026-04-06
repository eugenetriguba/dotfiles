;;; et-keys.el --- Set misc. custom keybindings -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;;; Code:

;; Make ESC quit prompts. C-g will also do this, but it's
;; a convienence for my vim-pilled brain.
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(provide 'et-keys)
;;; et-keys.el ends here
