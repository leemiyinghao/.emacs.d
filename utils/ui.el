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
  (spaceline-toggle-selection-info-on))

(use-package minions
  :defer t
  :hook (emacs-startup . minions-mode))

;; prefer horizontal split on new window
;; (setq split-width-threshold 1 )
(use-package page-break-lines)
(use-package dashboard
  :hook (elpaca-after-init-hook . dashboard-setup-startup-hook)
  :config
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-center-content t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-icon-type 'all-the-icons)
  (setq dashboard-projects-backend 'project-el)
  (setq dashboard-items '((recents  . 5)
                          (bookmarks . 5)
                          (projects . 5)
						  (agenda . 5))))
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(provide 'ui)
;;; ui.el ends here
