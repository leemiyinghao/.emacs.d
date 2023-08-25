(use-package projectile
  :defer t
  :config
  (setq projectile-sort-order 'recently-active)
  (setq projectile-enable-caching t)
  (setq projectile-file-exists-remote-cache-expire (* 10 60))
  (setq projectile-require-project-root t)
  :bind
  ("M-p" . projectile-command-map)
  :init
  (projectile-mode +1))
(use-package direnv
  :defer t
  :config
  (direnv-mode))
(use-package consult-projectile
  :defer t
  :after projectile
  :config (define-key projectile-mode-map (kbd "M-p") 'projectile-command-map))

