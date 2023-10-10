(use-package org-modern
  :after org
  :hook
  (org-mode . org-modern-mode)
  (org-agenda-finalize . org-modern-agenda)
  :config
  (global-org-modern-mode))

(use-package ob-http)

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
