"config-copilot"

(use-package copilot
  :ensure (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
  :hook ((prog-mode . copilot-mode)
         (git-commit-mode . copilot-mode)
         (org-mode . copilot-mode)
		 (yaml-mode . copilot-mode)
		 (yaml-ts-mode . copilot-mode))
  :bind (("M-RET" . copilot-accept-completion)
	 (:map org-mode-map
	       ("M-RET" . copilot-accept-completion)))
  ;; suppress warning
  :config (setq copilot-indent-offset-warning-disable t))

(provide 'config-copilot)
;;; config-copilot.el ends here
