;; Temporarily increase GC threshold during startup
(setq gc-cons-threshold most-positive-fixnum)

;; Restore to normal value after startup (e.g. 100MB)
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 100 1024 1024))))

