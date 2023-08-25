"lsp"

(use-package eglot
  :defer t
  :hook ((python-mode . eglot-ensure)
	 (python-ts-mode . eglot-ensure)
	 (rust-mode . eglot-ensure)
	 (vue-mode-reparse . eglot-ensure)
	 (text-mode . eglot-ensure)
	 (bibtex-mode . eglot-ensure)
	 (context-mode . eglot-ensure)
	 (latex-mode . eglot-ensure)
	 (markdown-mode . eglot-ensure)
	 (org-mode . eglot-ensure)
	 (rst-mode . eglot-ensure))
  :bind (("C-c l r" . eglot-rename)
	 ("C-<tab>" . eglot-code-actions))
  :config
  (add-to-list 'eglot-server-programs '(python-mode . ("pyright-langserver" "--stdio")))
  (add-to-list 'eglot-server-programs '(python-ts-mode . ("pyright-langserver" "--stdio")))
  (add-to-list 'eglot-server-programs '(vue-mode . ("vue-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs '('(text-mode bibtex-mode context-mode latex-mode markdown-mode org-mode rst-mode) . ("grammarly-languageserver" "--stdio" :initializationOptions (:clientId "client_BaDkMgx4X19X9UxxYRCXZo"))))
  (add-to-list 'eglot-stay-out-of 'company))

(use-package flymake-diagnostic-at-point
  :after flymake
  :config
  (add-hook 'flymake-mode-hook #'flymake-diagnostic-at-point-mode)
  (setq flymake-diagnostic-at-point-display-diagnostic-function 'flymake-diagnostic-at-point-display-minibuffer))

