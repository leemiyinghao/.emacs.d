(use-package org-modern
  :config
  (add-hook 'org-mode-hook #'org-modern-mode)
  (add-hook 'org-agenda-finalize-hook #'org-modern-agenda))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t) (shell . t)))
(custom-set-variables
 '(org-export-backends '(ascii beamer html icalendar latex md odt freemind))) 
