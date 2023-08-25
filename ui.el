;; disable bars
(tool-bar-mode -1)
(menu-bar-mode -1)

(use-package moody
  :config
  (setq x-underline-at-descent-line t)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode)
  (moody-replace-eldoc-minibuffer-message-function))
(use-package minions
  :config
  (minions-mode))

;; prefer horizontal split on new window
;; (setq split-width-threshold 1 )

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-display-icons-p t)
  (setq dashboard-icon-type 'nerd-icons)
  (setq dashboard-center-content t)
  (setq dashboard-icon-type 'all-the-icons)
  (setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5))))
