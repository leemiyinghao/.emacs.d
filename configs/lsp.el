"lsp"

;; (setq lsp-keymap-prefix "C-c l")

;; (use-package lsp-mode
;;   :ensure t
;;   :defer t
;;   :config
;;   (setq lsp-idle-delay 0.5
;;         lsp-enable-symbol-highlighting t
;;         lsp-enable-snippet nil
;; 	gc-cons-threshold 100000000
;; 	read-process-output-max (* 4096 4096)
;; 	lsp-log-io nil)
;;   (lsp-register-client
;;    (make-lsp-client :new-connection (lsp-stdio-connection "pylsp")
;;                     :activation-fn (lsp-activate-on "python")
;;                     :server-id 'pylsp))
;;   :hook
;;   ((lsp-mode . (lambda ()
;;                       (let ((lsp-keymap-prefix "C-c l"))
;;                         (lsp-enable-which-key-integration))))
;;   (python-mode . lsp)
;;   (rust-mode . lsp)
;;   ))
;; ; (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)

;; (use-package lsp-ui
;;   :ensure t
;;   :config (setq lsp-ui-sideline-show-hover t
;;                 lsp-ui-sideline-delay 0.5
;; 		lsp-ui-peek-always-show t
;; 		lsp-ui-doc-enable t
;;                 lsp-ui-doc-delay 5
;;                 lsp-ui-doc-position 'bottom
;;                 lsp-ui-doc-alignment 'frame
;;                 lsp-ui-doc-header nil
;;                 lsp-ui-doc-include-signature t
;;                 lsp-ui-doc-use-childframe t)
;;   :commands lsp-ui-mode)

(use-package eglot
  :defer t
  :hook ((python-mode . eglot-ensure)
	 (rust-mode . eglot-ensure))
  :bind (("C-c l = =" . eglot-format)
	 ("C-c l r" . eglot-rename))
  :config (add-to-list 'eglot-server-programs '(python-mode . ("pyright-langserver" "--stdio"))))

(use-package flymake-diagnostic-at-point
  :after flymake
  :config
  (add-hook 'flymake-mode-hook #'flymake-diagnostic-at-point-mode)
  (setq flymake-diagnostic-at-point-display-diagnostic-function 'flymake-diagnostic-at-point-display-minibuffer))

;; (use-package eldoc-overlay
;;   :init (eldoc-overlay-mode 1)
;;   :config
;;   (setq eldoc-overlay-backend 'quick-peek))

