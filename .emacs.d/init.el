;;; init.el --- Emacs Configuration entrypoint -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; init.el serves as the entrypoint for this Emacs configuration.
;;
;; The majority of the configuration lives within the lisp/ directory.
;; Each Lisp file is intended to be a self-contained unit for some aspect
;; of my usage of Emacs.  Each file name and definitions within a file
;; are prefixed with et- to namespace them.
;;
;; Because the configuration is generally in these self-contained Lisp
;; files, the primary role of init.el is to bootstrap the loading of these
;; files.
;;
;; Therefore, this entrypoint file:
;; * Sets up the Emacs load path to include the Lisp directory.
;; * Loads each Lisp file in the necessary order.
;;
;;; Code:
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'et-package)
(require 'et-tidy)
(require 'et-appearance)
(require 'et-vi)
(require 'et-keys)
(require 'et-vc)
(require 'et-completion)
(require 'et-format)
(require 'et-lsp)
(require 'et-lang)
(require 'et-md)
(require 'et-org)

(provide 'init)
;;; init.el ends here
