;;; et-vc.el --- Version control configuration -*- lexical-binding:t -*-
;;; Commentary:
;;; Code:
(require 'vc-git)

(use-package project)

(use-package magit
  :ensure t)

(setq vc-follow-symlinks t)

(global-set-key (kbd "C-c gu")
                'et-generate-remote-git-url)

(defun et-generate-remote-git-url ()
  "Generate a remote URL for the current buffer file and line number.

* The remote URL can be HTTPS or SSH.
* The git hosting provider is determined via the git remote `origin` url.
* Only Github and SourceHut are supported as a hosting provider.

For example, if the point is on line 12 of example.el on head SHA
abc123, and the git remote origin url is set to a github URL, then a
URL such https://github.com/myuser/myrepo/blob/abc123/example.el#L12
would be added to the kill ring."
  (interactive)

  (if (not buffer-file-name)
      (message "Not visiting a file.")
    (let* ((remote-url (vc-git-repository-url buffer-file-name "origin"))
	   (head-sha (vc-git-working-revision buffer-file-name))
           (relative-file-path (file-relative-name buffer-file-name
						   (vc-git-root buffer-file-name)))
           (line-num (line-number-at-pos)))

      (if (et--is-supported-provider-p remote-url)
	  (progn
            (kill-new (et--generate-remote-git-url remote-url head-sha relative-file-path line-num))
            (message "Copied remote git URL"))
	(message (format "%s is not a supported git hosting provider." remote-url))))))

(defun et--is-supported-provider-p (url)
  "Check whether URL is a supported git hosting provider for URL generation."
  (not (null (et--get-git-hosting-provider url))))

(defun et--get-git-hosting-provider (url)
  "Get the git hosting provider for the given URL.

The supported providers are github and sourcehut.  If the URL
corresponds to an unsupported provider, null is returned."
  (cond
   ((string-match-p "github\\.com" url) 'github)
   ((string-match-p "git\\.sr\\.ht" url) 'sourcehut)))

(defun et--generate-remote-git-url (remote-url head-sha relative-file-path line-num)
  (let ((provider (et--get-git-hosting-provider remote-url)))
    (cond
     ((eq 'github provider)
      (et--gh-generate-remote-git-url remote-url head-sha relative-file-path line-num))
     ((eq 'sourcehut provider)
      (et--sh-generate-remote-git-url remote-url head-sha relative-file-path line-num)))))

(defun et--gh-generate-remote-git-url (remote-url head-sha relative-file-path line-num)
  (format "https://github.com/%s/blob/%s/%s#L%d"
	  (et--extract-repo-path "https://github.com" remote-url)
	  head-sha
	  relative-file-path
	  line-num))

(defun et--sh-generate-remote-git-url (remote-url head-sha relative-file-path line-num)
  (format "https://git.sr.ht/%s/tree/%s/item/%s#L%d"
	  (et--extract-repo-path "https://git.sr.ht" remote-url)
	  head-sha
	  relative-file-path
	  line-num))

(defun et--extract-repo-path (base-url remote-url)
  "Extract the repository path from the REMOTE-URL.

BASE-URL is used to determine where the repository part of the
REMOTE-URL starts if the REMOTE-URL is a http URL.

Example:
  (et--extract-repo-path
    \"https://github.com\"
    \"https://github.com/user/repo\")
  => \"user/repo\"

  (et--extract-repo-path
    \"https://git.sr.ht\"
    \"git@git.sr.ht:~eugenetriguba/repo\")
  => \"~eugenetriguba/repo\""
  (if (et--git-ssh-url-p remote-url)
      (substring remote-url (+ 1 (string-match ":" remote-url)))
    (replace-regexp-in-string
     (format "%s/\\(.*?\\)\\(.git\\)?$" base-url)
     "\\1"
     remote-url)))

(defun et--git-ssh-url-p (url)
  "Check whether URL is a SSH-based Git origin URL."
  (string-prefix-p "git@" url))

(provide 'et-vc)
;;; et-vc.el ends here
