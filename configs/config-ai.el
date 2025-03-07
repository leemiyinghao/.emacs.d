;;; config-ai.el --- AI related packages -*- lexical-binding: t -*-

(use-package elysium
  :ensure (:host github :repo "lanceberge/elysium"))

(use-package plz-event-source
  :ensure (:host github :repo "r0man/plz-event-source"))
(use-package plz-media-type
  :ensure (:host github :repo "r0man/plz-media-type"))

(use-package llm
  :ensure (:host github :repo "ahyatt/llm")
  :init
  (require 'llm-openai)
  (setq llm-openrouter-provider
		(make-llm-openai-compatible
		 :url "https://openrouter.ai/api/v1/"
		 :key (getenv "OPENROUTER_API_KEY")
		 :chat-model "anthropic/claude-3.5-haiku"
		 :embedding-model "anthropic/claude-3.5-haiku"))
  :custom
  (llm-warn-on-nonfree nil))

(use-package magit-gptcommit
  :demand t
  :after magit llm
  :bind (:map git-commit-mode-map
              ("C-c C-g" . magit-gptcommit-commit-accept))
  :custom
  (magit-gptcommit-llm-provider llm-openrouter-provider)
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
