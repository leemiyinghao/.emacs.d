"lsp"

(use-package flymake-diagnostic-at-point
  :defer t
  :after flymake
  :hook (flymake-mode . flymake-diagnostic-at-point-mode)
  :config
  (setq flymake-diagnostic-at-point-display-diagnostic-function 'flymake-diagnostic-at-point-display-minibuffer))

(use-package lsp-mode
  :defer t
  :hook
  ((bash-ts-mode
    sh-mode
    cmake-ts-mode
    cmake-mode
    rust-ts-mode
    rust-mode
    ;; go-ts-mode
    ;; go-mode
    json-ts-mode
    json-mode
    vue-mode
    js-ts-mode
    javascript-mode
    typescript-ts-mode
    typescript-mode
    html-mode
    svelte-mode
    php-mode
    kotlin-ts-mode
    kotlin-mode
    yaml-ts-mode
    yaml-mode
    swift-mode
    ansible)
   ;; python-ts-mode
   ;; python-mode)
   .
   lsp-deferred)
  :bind
  (:map lsp-mode-map
		("C-c l r" . lsp-rename)
		("C-<tab>" . lsp-execute-code-action))
  :config
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-file-watch-threshold 4096)
  ;; servers
  (lsp-ensure-server 'pyright)
  (lsp-ensure-server 'ruff-lsp)
  (lsp-ensure-server 'gopls)
  (lsp-ensure-server 'rust-analyzer)
  (lsp-ensure-server 'css-ls)
  (lsp-ensure-server 'html-ls)
  (lsp-ensure-server 'svelte-ls)
  (lsp-ensure-server 'vue-semantic-server)
  (lsp-ensure-server 'ansible-ls))
(use-package lsp-ui
  :after lsp-mode
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  (setq lsp-completion-provider :none))

(use-package consult-lsp
  :after lsp-mode)

;; special lsp languages
;; spellcheck
(use-package lsp-grammarly
  :after lsp-mode
  :hook (text-mode . (lambda ()
					   (require 'lsp-grammarly)
					   (lsp-deferred))))

;; frontend
(use-package lsp-sourcekit
  :after lsp-mode
  :config
  (setq lsp-sourcekit-executable (string-trim (shell-command-to-string "xcrun --find sourcekit-lsp"))))

;; misc

(setq read-process-output-max (* 1024 1024))

(use-package eglot
  :defer t
  :hook ((;; backend
		  python-ts-mode
		  go-mode
		  go-ts-mode)
		 . eglot-ensure)

  :bind (:map eglot-mode-map
			  ("C-c l r" . eglot-rename)
			  ("C-<tab>" . eglot-code-actions))

  :config
  (mapc (lambda (program) (add-to-list 'eglot-server-programs program))
		'(;; grammarly for text-main modes.
		  (python-ts-mode . ("pyright-langserver" "--stdio"))
		  ((go-mode go-ts-mode) . ("gopls" "serve")))))


(provide 'config-lsp)
;;; config-lsp.el ends here
