(use-package projectile
  :config
  (setq projectile-sort-order 'recently-active)
  (setq projectile-enable-caching t)
  (setq projectile-file-exists-remote-cache-expire (* 10 60))
  (setq projectile-require-project-root t)
  :bind
  ("C-c p" . projectile-command-map)
  :init
  (projectile-mode +1))
