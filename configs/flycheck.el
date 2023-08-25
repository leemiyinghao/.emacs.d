(use-package flycheck
  :defer t
  :config
  (global-flycheck-mode)
  (custom-set-variables '(flycheck-checker-error-threshold 4096)))
;; (add-hook 'after-init-hook #'global-flycheck-mode)
;; (custom-set-variables '(flycheck-checker-error-threshold 4096))
