(use-package go-mode
  :mode (("\\.go\\'" . go-ts-mode)))

;; DAP mode for debugging
(use-package dap-mode
  :init
  (require 'dap-dlv-go)
  :hook
  (go-ts-mode . dap-mode)
  (go-ts-mode . dap-ui-mode)
  (go-ts-mode . dap-auto-configure-mode))
