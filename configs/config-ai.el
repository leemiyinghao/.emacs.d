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

(use-package aider
  :ensure (:host github :repo "tninja/aider.el" :files ("aider.el"))
  :config
  (setq aider-args '("--model" "ollama/llama3.1:8b"))
  (setenv "OLLAMA_API_BASE" "https://ollama.ryzen.catlee.se")
  ;; Optional: Set a key binding for the transient menu
  (global-set-key (kbd "C-c a") 'aider-transient-menu))


(provide 'config-ai)
;;; config-ai.el ends here
