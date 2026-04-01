;; First, we want to setup package.el for installing packages.
;; This is emac's built-in package manager, and we'll use it
;; to install use-package itself.
;;
;; To list the packages and see what is avaiable, we can use
;; M-x list-packages.
(require 'package)

;; Package archives are where we want to install packages from.
;; It is expected that we setup this variable before we call
;; package-initialize.
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; If use package isn't installed on the current system,
;; we want to build the package contents and install use-package.
;;
;; Do note that the package contents can get out of date, and there
;; is no automatic process here for refreshing them. Instead, we'll
;; need to do M-x package-refresh-contents occasionally.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

;; Always ensure anything used via use-package is installed.
(setq use-package-always-ensure t)

(provide 'et-package)
