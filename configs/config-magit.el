(use-package transient)
(use-package magit
  :ensure (:host github :repo "magit/magit")
  :defer t
  :config
  (global-git-commit-mode 1))
(use-package forge
  :defer t
  :after magit)
(use-package magit-todos
  :defer t
  :after magit)
(use-package forge
  :defer t
  :after magit)
(use-package abridge-diff
  :after magit
  :init (abridge-diff-mode 1))

(provide 'config-magit)
;;; config-magit.el ends here
