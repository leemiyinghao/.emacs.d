(defun python-hook ()
  (use-package poetry
    :ensure t)
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection "pylsp")
                    :activation-fn (lsp-activate-on "python")
                    :server-id 'pylsp)))
(add-hook 'python-mode 'python-hook)

(use-package jupyter)
