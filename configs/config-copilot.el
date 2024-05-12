"config-copilot"

(use-package copilot
  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
  :hook (prog-mode . copilot-mode)
  :bind (("M-<return>" . copilot-accept-completion))
  ;; suppress warning
  :config (setq copilot-indent-offset-warning-disable t))

(provide 'config-copilot)
;;; config-copilot.el ends here
