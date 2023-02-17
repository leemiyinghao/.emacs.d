(use-package flycheck :ensure t)
(add-hook 'after-init-hook #'global-flycheck-mode)
(custom-set-variables '(flycheck-checker-error-threshold 4096))
