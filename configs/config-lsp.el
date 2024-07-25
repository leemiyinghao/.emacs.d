"lsp"

(use-package flymake-diagnostic-at-point
  :defer t
  :after flymake
  :hook (flymake-mode . flymake-diagnostic-at-point-mode)
  :config
  (setq flymake-diagnostic-at-point-display-diagnostic-function 'flymake-diagnostic-at-point-display-minibuffer))

(use-package lsp-mode
  :defer t
  :preface
  (defun lsp-booster--advice-json-parse (old-fn &rest args)
    "Try to parse bytecode instead of json."
    (or
     (when (equal (following-char) ?#)

       (let ((bytecode (read (current-buffer))))
         (when (byte-code-function-p bytecode)
           (funcall bytecode))))
     (apply old-fn args)))
  (defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
    "Prepend emacs-lsp-booster command to lsp CMD."
    (let ((orig-result (funcall old-fn cmd test?)))
      (if (and (not test?)                             ;; for check lsp-server-present?
               (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
               lsp-use-plists
               (not (functionp 'json-rpc-connection))  ;; native json-rpc
               (executable-find "emacs-lsp-booster"))
          (progn
            (message "Using emacs-lsp-booster for %s!" orig-result)
            (cons "emacs-lsp-booster" orig-result))
        orig-result)))
  :init
  (setq lsp-use-plists t)
  ;; Initiate https://github.com/blahgeek/emacs-lsp-booster for performance
  (advice-add (if (progn (require 'json)
                         (fboundp 'json-parse-buffer))
                  'json-parse-buffer
                'json-read)
              :around
              #'lsp-booster--advice-json-parse)
  (advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command)
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
  (lsp-mode . lsp-enable-which-key-integration)
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
