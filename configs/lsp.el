"lsp"

(use-package eglot
  :defer t
  :hook ((;; util
	  bash-ts-mode
	  cmake-ts-mode
	  ;; backend
	  python-ts-mode
	  rust-ts-mode
	  go-ts-mode
	  ;; frontend
	  json-ts-mode
	  vue-mode
	  js-ts-mode
	  typescript-ts-mode
	  php-mode
	  ;; misc
	  text-mode
	  bibtex-mode
	  context-mode
	  latex-mode
	  markdown-mode
	  org-mode
	  yaml-ts-mode
	  rst-mode)
	 . eglot-ensure)

  :bind (("C-c l r" . eglot-rename)
	 ("C-<tab>" . eglot-code-actions))

  :config
  (mapc (lambda (program) (add-to-list 'eglot-server-programs program))
	'(;; grammarly for text-main modes.
	  ('(text-mode
	     bibtex-mode
	     context-mode
	     latex-mode
	     markdown-mode
	     org-mode
	     rst-mode)
	   .
	   ("grammarly-languageserver" "--stdio"
	    :initializationOptions (:clientId "client_BaDkMgx4X19X9UxxYRCXZo")))
	  ;; language server for programming language
	  (python-ts-mode . ("pyright-langserver" "--stdio"))
	  (vue-mode . ("vue-language-server" "--stdio"))
	  (typescript-ts-mode . ("typescript-language-server" "--stdio"))
	  (js-ts-mode . ("typescript-language-server" "--stdio"))
	  (go-ts-mode . ("gopls"  "serve"))
	  (svelte-mode . ("svelteserver" "--stdio"))
	  (bash-ts-mode . ("bash-language-server" "start"))
	  (cmake-ts-mode . ("cmake-language-server"))
	  (php-mode . ("intelephense" "--stdio"))
	  (json-ts-mode . ("vscode-json-language-server" "--stdio"))
	  (yaml-ts-mode . ("yaml-language-server" "--stdio")))))

(use-package flymake-diagnostic-at-point
  :after flymake
  :config
  (add-hook 'flymake-mode-hook #'flymake-diagnostic-at-point-mode)
  (setq flymake-diagnostic-at-point-display-diagnostic-function 'flymake-diagnostic-at-point-display-minibuffer))

