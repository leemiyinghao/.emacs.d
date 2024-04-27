;; disable bars
(tool-bar-mode -1)
(menu-bar-mode -1)

(use-package nyan-mode
  :defer t
  :hook (emacs-startup . nyan-mode))

(use-package spaceline
  :defer t
  :hook (emacs-startup . spaceline-spacemacs-theme)
  :init
  (setq powerline-default-separator 'wave)
  :config
  (require 'spaceline-config)
  (spaceline-toggle-nyan-cat-on)
  (spaceline-toggle-selection-info-on)
  (spaceline-toggle-projectile-root-on))

(use-package minions
  :defer t
  :hook (emacs-startup . minions-mode))

;; prefer horizontal split on new window
;; (setq split-width-threshold 1 )

(use-package dashboard
  :defer t
  :hook (after-init . dashboard-setup-startup-hook)
  :config
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-center-content t)
  (setq dashboard-icon-type 'all-the-icons)
  (setq dashboard-items '((recents  . 5)
                          (bookmarks . 5)
                          (projects . 5))))

(global-hl-line-mode t)

(provide 'ui)
;;; ui.el ends here
