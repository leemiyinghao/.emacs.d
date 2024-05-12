"config-copilot"

(use-package copilot
  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
  :hook (prog-mode . copilot-mode)
        (git-commit-mode . copilot-mode)
        (org-mode . copilot-mode)
  :bind (("M-RET" . copilot-accept-completion)
	 ("M-<return>" . copilot-accpet-completion))
  ;; suppress warning
  :config (setq copilot-indent-offset-warning-disable t))

(provide 'config-copilot)
;;; config-copilot.el ends here
