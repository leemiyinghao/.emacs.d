"lsp"

(use-package flymake-diagnostic-at-point
  :after flymake
  :config
  (add-hook 'flymake-mode-hook #'flymake-diagnostic-at-point-mode)
  (setq flymake-diagnostic-at-point-display-diagnostic-function 'flymake-diagnostic-at-point-display-minibuffer))

(use-package lsp-mode
  :hook
  ((bash-ts-mode
    cmake-ts-mode
    rust-ts-mode
    go-ts-mode
    json-ts-mode
    vue-mode
    js-ts-mode
    typescript-ts-mode
    html-mode
    svelte-mode
    php-mode
    kotlin-ts-mode
    yaml-ts-mode
    ansible-mode)
   .
   lsp-deferred)
  :bind
  ("C-c l r" . lsp-rename)
  ("C-<tab>" . lsp-execute-code-action)
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
  (lsp-ensure-server 'vue-semantic-server))
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
;; backend
(use-package lsp-pyright
  :after lsp-mode
  :hook ((python-mode python-ts-mode) . (lambda ()
					  (require 'lsp-pyright)
					  (lsp-deferred))))
;; frontend
;; misc
