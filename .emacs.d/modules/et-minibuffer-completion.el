;;; et-completion.el --- Enhance the Emacs completion behavior -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;;; Code:

;; Add a vertical completion UI
(use-package vertico
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

;; Adjust completion search behavior
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-pcm-leading-wildcard t))

;; Persist history over emacs restarts.
;; This allows vertico to sort by history position.
(use-package savehist
  :init
  (savehist-mode))

;; Add documentation alongside the completion items
(use-package marginalia
  :init
  (marginalia-mode))

(provide 'et-completion)
;;; et-completion.el ends here
