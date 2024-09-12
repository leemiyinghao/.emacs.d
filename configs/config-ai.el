;;; config-ai.el --- AI related packages -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(use-package gptel)

(use-package elysium
  :ensure (:host github :repo "lanceberge/elysium"))

(use-package magit-gptcommit
  :demand t
  :after magit
  :bind (:map git-commit-mode-map
              ("C-c C-g" . magit-gptcommit-commit-accept))
  :config
  (magit-gptcommit-status-buffer-setup))


(provide 'config-ai)
;;; config-ai.el ends here
