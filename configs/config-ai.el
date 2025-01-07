;;; config-ai.el --- AI related packages -*- lexical-binding: t -*-
(use-package gptel
  :config (setq gptel-model my-llm-model))

(use-package elysium
  :ensure (:host github :repo "lanceberge/elysium"))

(use-package magit-gptcommit
  :demand t
  :after magit
  :bind (:map git-commit-mode-map
              ("C-c C-g" . magit-gptcommit-commit-accept))
  :config
  (magit-gptcommit-status-buffer-setup))

(use-package aider
  :ensure (:host github :repo "tninja/aider.el" :files ("aider.el"))
  :config
  (setq aider-args (list
					"--no-auto-commits"
					"--model" aider-model))
  (global-set-key (kbd "C-c a") 'aider-transient-menu))

(provide 'config-ai)
;;; config-ai.el ends here
