(use-package org-modern
  :after org
  :hook
  (org-mode . org-modern-mode)
  (org-agenda-finalize . org-modern-agenda)
  :config
  (global-org-modern-mode))

(use-package ob-http)

(use-package org-auto-tangle
  :load-path "site-lisp/org-auto-tangle/"    ;; this line is necessary only if you cloned the repo in your site-lisp directory 
  :defer t
  :hook (org-mode . org-auto-tangle-mode))

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

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (shell . t)
   (emacs-lisp . t)
   (http . t)))

(setq org-support-shift-select t)
(define-key org-mode-map (kbd "M-<left>") nil)
(define-key org-mode-map (kbd "M-<up>") nil)
(define-key org-mode-map (kbd "M-<right>") nil)
(define-key org-mode-map (kbd "M-<down>") nil)

(custom-set-variables
 '(org-export-backends '(ascii beamer html icalendar latex md odt freemind))) 
