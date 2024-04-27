(defun go-mode-dap-hook ()
  (dap-mode t)
  (dap-ui-mode t)
  (dap-auto-configure-mode t))

;; DAP mode for debugging
(use-package dap-mode
  :defer t
  :config
  (require 'dap-dlv-go)
  :hook
  (go-ts-mode . go-mode-dap-hook))

(use-package gorepl-mode
  :defer t)

(provide 'config-golang)
;;; config-golang.el ends here
