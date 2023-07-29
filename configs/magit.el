(use-package magit :ensure t)
(use-package forge
  :defer t
  :after magit)
(use-package magithub
  :defer t
  :after magit)
(use-package magit-todos
  :defer t
  :after magit)
(global-git-commit-mode 1)
