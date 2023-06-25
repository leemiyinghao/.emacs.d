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
