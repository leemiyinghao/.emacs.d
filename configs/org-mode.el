(use-package org-modern
  :after org
  :hook
  (org-mode . org-modern-mode)
  (org-agenda-finalize . org-modern-agenda)
  :config
  (global-org-modern-mode))

(use-package ob-http)


(use-package org-download
  :config
  ;; Drag and drop to Dired
  (setq org-download-link-format "[[file:%s]]\n"
	org-download-image-org-width 600
	org-download-abbreviate-filename-function #'file-relative-name)
  (add-hook 'dired-mode-hook 'org-download-enable)
  :bind
  (:map org-mode-map
	("C-s-y" . org-download-clipboard)))

;; custom css when export
(defun add-org-mode-default-head-hook (exporter)
  "Insert custom inline css and js"
  (when (eq exporter 'html)
    (let* ((default-css-path "~/.emacs.d/configs/org-mode.css")
	   (default-external-js-alist (list "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.8.0/highlight.min.js"))
	   (default-js-path "~/.emacs.d/configs/org-mode.js"))
      (if (file-exists-p default-css-path)
	  (setq org-html-head (concat
			       org-html-head
                               "<style type=\"text/css\">\n"
                               (with-temp-buffer (insert-file-contents default-css-path) (buffer-string))
                               "</style>\n"))
	(message "org-mode.css not found."))
      (setq org-html-head
	    (concat
	     org-html-head
	     (mapconcat (lambda (url) (format "<script src=\"%s\"></script>" url)) default-external-js-alist)))
      (if (file-exists-p default-js-path)
	  (setq org-html-head (concat
			       org-html-head
                               "<script>\n"
                               (with-temp-buffer (insert-file-contents default-js-path) (buffer-string))
                               "</script>\n"))
	(message "org-mode.js not found."))
      (message "default-js-path-alist: %s" (sequencep default-external-js-alist)))))

(add-hook 'org-export-before-processing-hook 'add-org-mode-default-head-hook)

;; postamble format
(setq org-html-postamble
      (lambda
	(info)
	(format
	 (concat "<p class=\"author\">by <a href=\"mailto:%s\">%s</a></p>"
		 "<p class=\"creator\">%s</p>")
	 user-mail-address
	 user-full-name
	 org-export-creator-string)))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (shell . t)
   (emacs-lisp . t)
   (http . t)))

(setq org-startup-with-inline-images t)
(setq org-support-shift-select t)
(define-key org-mode-map (kbd "M-<left>") nil)
(define-key org-mode-map (kbd "M-<up>") nil)
(define-key org-mode-map (kbd "M-<right>") nil)
(define-key org-mode-map (kbd "M-<down>") nil)

(custom-set-variables
 '(org-export-backends '(ascii beamer html icalendar latex md odt))) 
(setq org-image-actual-width '(300))
