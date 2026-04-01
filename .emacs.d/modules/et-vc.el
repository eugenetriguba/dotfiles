;;; -*- Lexical-binding:t -*-
(require 'vc-git)

(global-set-key (kbd "C-c gu")
                'et-generate-remote-git-url)

(defun et-generate-remote-git-url ()
  "Generate a remote URL for the current buffer file and line number.

  * The remote URL can be HTTPS or SSH.
  * The git hosting provider is determined via the git remote origin url.
  * Only Github and SourceHut are supported as a hosting provider."
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
  "Check whether url is a supported git hosting provider for URL generation."
  (not (null (et--get-git-hosting-provider url))))

(defun et--get-git-hosting-provider (url)
  "Get the git hosting provider for the given url.

  Supported providers:
    - github
    - sourcehut

  Otherwise, if the url corresponds to an unsupported provider,
  nil is returned."
  (cond
   ((string-match-p "github\\.com" url) "github")
   ((string-match-p "git\\.sr\\.ht" url) "sourcehut")))

(defun et--generate-remote-git-url (remote-url head-sha relative-file-path line-num)
  (let ((provider (et--get-git-hosting-provider remote-url)))
    (cond
     ((string-match-p "github" provider)
      (et--gh-generate-remote-git-url remote-url head-sha relative-file-path line-num))
     ((string-match-p "sourcehut" provider)
      (et--sh-generate-remote-git-url remote-url head-sha relative-file-path line-num)))))


(defun et--gh-generate-remote-git-url (remote-url head-sha relative-file-path line-num)
  (format "https://github.com/%s/blob/%s/%s#L%d"
	  (et--extract-repo-path "https://github.com" remote-url)
	  head-sha
	  relative-file-path
	  line-num))

(defun et--extract-repo-path (base-url remote-url)
  (if (et--git-ssh-url-p remote-url)
      (substring remote-url (+ 1 (string-match ":" remote-url)))
    (replace-regexp-in-string
     (format "%s/\\(.*?\\)\\(.git\\)?$" base-url)
     "\\1"
     remote-url)))

(defun et--git-ssh-url-p (url)
  (string-prefix-p "git@" url))

(defun et--sh-generate-remote-git-url (remote-url head-sha relative-file-path line-num)
  (format "https://git.sr.ht/%s/tree/%s/item/%s#L%d"
	  (et--extract-repo-path "https://git.sr.ht" remote-url)
	  head-sha
	  relative-file-path
	  line-num))

(provide 'et-vc)

