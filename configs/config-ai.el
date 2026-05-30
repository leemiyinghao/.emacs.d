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
		 :chat-model "google/gemini-3.5-flash"
		 :embedding-model "google/gemini-3.5-flash"))
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

(use-package aidermacs
  :ensure (:host github :repo "MatthewZMD/aidermacs" :files ("*.el"))
  :config
  (setq aidermacs-args (list
                        "--no-auto-commits"
                        "--model" aider-model))
  (setq aidermacs-show-diff-after-change nil)
  (global-set-key (kbd "C-c a") 'aidermacs-transient-menu))


(provide 'config-ai)
;;; config-ai.el ends here
