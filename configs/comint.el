(use-package comint-mime
  :defer t
  :config
  (add-hook 'shell-mode-hook 'comint-mime-setup)
  (add-hook 'inferior-python-mode-hook 'comint-mime-setup)
  (when (executable-find "ipython3")
    (setq python-shell-interpreter "ipython3"
          python-shell-interpreter-args "--simple-prompt --classic")))

