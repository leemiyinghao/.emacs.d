;;; lsp.el --- LSP configuration -*- lexical-binding: t -*-
"lsp"
;;; Commentary:
;; LSP configuration. Using lsp-mode as the main client, and eglot as a fallback.
;;; Code:
(use-package flymake-posframe
  :defer t
  :ensure (:host github :repo "Ladicle/flymake-posframe" files ("flymake-posframe.el"))
  :after flymake
  :hook (flymake-mode . flymake-posframe-mode))

(use-package spinner
  :ensure (:host github :repo "Malabarba/spinner.el"))

(use-package lsp-mode
  :ensure t
  :preface

  (defun my/lsp-remote-server-present-p (original command)
    "Check absolute server executables on the host running COMMAND."
    (let ((remote (file-remote-p default-directory))
          (program (car command)))
      (if (and remote (file-name-absolute-p program))
          (and (file-executable-p (concat remote program)) program)
        (funcall original command))))

  (defun my/lsp-remote-package-path (original &rest args)
    "Resolve managed language servers in the remote host's Emacs cache."
    (let ((lsp-server-install-dir
           (if (file-remote-p default-directory)
               (expand-file-name
                (concat (file-remote-p default-directory) "~/.emacs.d/.cache/lsp/"))
             lsp-server-install-dir)))
      (let ((path (apply original args)))
        (if (and path (file-remote-p default-directory))
            (file-local-name path)
          path))))

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
    ;; RPC starts processes directly, so skip TRAMP's terminal shell wrapper.
	(let ((orig-result (funcall old-fn cmd
                                    (or test? (equal (file-remote-p default-directory 'method)
                                                      "rpc")))))
      (if (and (not test?)                             ;; for check lsp-server-present?
               (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
               lsp-use-plists
               (not (functionp 'json-rpc-connection))  ;; native json-rpc
               (executable-find "emacs-lsp-booster"))
          (progn
			(when-let ((command-from-exec-path (executable-find (car orig-result))))  ;; resolve command from exec-path (in case not found in $PATH)
              (setcar orig-result command-from-exec-path))
			(message "Using emacs-lsp-booster for %s!" orig-result)
			(cons "emacs-lsp-booster" orig-result))
		orig-result)))

  :init
  (advice-add 'lsp-server-present? :around #'my/lsp-remote-server-present-p)
  (advice-add 'lsp-package-path :around #'my/lsp-remote-package-path)
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
    json-ts-mode
    json-mode
    vue-mode
    html-mode
    svelte-mode
    php-mode
    yaml-ts-mode
    yaml-mode
    swift-mode
    ansible
	graphql-mode
	graphql-ts-mode
	typescript-ts-mode
	tsx-ts-mode
	js-ts-mode
	json-ts-mode)
   .
   lsp-deferred)
  (lsp-mode . lsp-enable-which-key-integration)

  :bind
  (:map lsp-mode-map
		("C-c l r" . lsp-rename)
		("C-c l g r" . lsp-find-references)
		("C-<tab>" . lsp-execute-code-action))

  :config
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-file-watch-threshold 4096)
  (setq read-process-output-max (* 1024 1024)) ; 1MB
  (setq lsp-log-io nil)
  (setq lsp-enable-symbol-highlighting nil)
  (setq lsp-vtsls-settings
		'(:typescript (:tsserver (:maxTsServerMemory 8192))
					  :javascript (:tsserver (:maxTsServerMemory 8192))))
  
  (setq lsp-file-watch-ignored-directories
		'("[/\\\\]\\.git\\'"
          "[/\\\\]node_modules\\'"
          "[/\\\\]dist\\'"
          "[/\\\\]build\\'"
          "[/\\\\]\\.next\\'"
          "[/\\\\]coverage\\'"))
  ;; servers
  (lsp-ensure-server 'pyright)
  (lsp-ensure-server 'gopls)
  (lsp-ensure-server 'rust-analyzer)
  (lsp-ensure-server 'css-ls)
  (lsp-ensure-server 'html-ls)
  (lsp-ensure-server 'typescript-language-server)
  (lsp-ensure-server 'json-ls)
  (lsp-ensure-server 'svelte-ls)
  (lsp-ensure-server 'vue-semantic-server)
  (lsp-ensure-server 'ansible-ls)
  (lsp-ensure-server 'vtsls)

  :custom
  (lsp-completion-provider :none)       ; Using Corfu as the provider
  (lsp-diagnostics-provider :flymake)   ; Using flymake as the provider
  (lsp-session-file (locate-user-emacs-file ".lsp-session"))
  (lsp-keep-workspace-alive t)          ; Reuse servers when project files are reopened
  (lsp-idle-delay 0.5)                  ; Debounce timer for `after-change-function'
  ;; core
  (lsp-enable-xref t)                   ; Use xref to find references
  (lsp-auto-configure t)                ; Used to decide between current active servers
  (lsp-eldoc-enable-hover t)            ; Display signature information in the echo area
  (lsp-enable-dap-auto-configure t)     ; Debug support
  (lsp-enable-file-watchers nil)
  (lsp-enable-folding nil)              ; I disable folding since I use origami
  (lsp-enable-imenu t)
  (lsp-enable-indentation nil)          ; I use prettier
  (lsp-enable-on-type-formatting nil)   ; Prettier handles this
  (lsp-enable-suggest-server-download t) ; Useful prompt to download LSP providers
  (lsp-enable-symbol-highlighting t)     ; Shows usages of symbol at point in the current buffer
  (lsp-enable-text-document-color nil)   ; This is Treesitter's job
  )

(use-package consult-lsp
  :after lsp-mode)

(use-package lsp-eslint
  :ensure nil
  :after lsp-mode
  :preface
  (defun my/lsp-eslint-server-command (original)
    "Use the remote ESLint language server when visiting TRAMP files."
    (if (file-remote-p default-directory)
        ;; Expand HOME on the remote host, not in the local Emacs.
        '("sh" "-c"
          "exec \"$HOME/.emacs.d/.cache/lsp/npm/vscode-langservers-extracted/bin/vscode-eslint-language-server\" --stdio")
      (funcall original)))
  :config
  (advice-add 'lsp-eslint-server-command :around #'my/lsp-eslint-server-command))

;; frontend
(use-package lsp-sourcekit
  :after lsp-mode
  :config
  (setq lsp-sourcekit-executable (string-trim (shell-command-to-string "xcrun --find sourcekit-lsp"))))

(setq lsp-tailwindcss-add-on-mode t)
(use-package lsp-tailwindcss
  :after lsp-mode
  :init
  (setq lsp-tailwindcss-skip-config-check t))

(use-package lsp-vtsls
  :after lsp-mode
  :ensure (:host github :repo "sdvcrx/lsp-vtsls")
  :config
  (setq
   ;; show all LSP doc on minibuffer
   lsp-eldoc-render-all t
   ;; https://github.com/yioneko/vtsls#bad-performance-of-completion
   lsp-vtsls-server-side-fuzzy-match t))

;; misc

(setq read-process-output-max (* 1024 1024))

(use-package eglot
  :defer t
  :preface
  (defvar-local config-lsp-kotlin-project-root nil
    "Kotlin Eglot root, absolute or relative to the normal project root.
Set this in directory-local variables for projects needing an override.
Nil preserves normal project detection.")
  (put 'config-lsp-kotlin-project-root 'safe-local-variable #'stringp)

  (defun config-lsp-kotlin-project-find (directory)
    "Apply a directory-local Kotlin Eglot root override for DIRECTORY."
    (when (and (bound-and-true-p eglot-lsp-context)
               (memq major-mode '(kotlin-mode kotlin-ts-mode))
               (stringp config-lsp-kotlin-project-root))
      (let* ((project (let ((eglot-lsp-context nil))
                        (project-current nil directory)))
             (root (file-name-as-directory
                    (expand-file-name config-lsp-kotlin-project-root
                                      (if project (project-root project) directory)))))
        (when (file-directory-p root)
          (cons 'transient root)))))
  :custom
  (eglot-connect-timeout 300)
  :hook ((;; backend
		  python-ts-mode
		  rust-mode
		  rust-ts-mode
		  kotlin-ts-mode
		  kotlin-mode
		  go-mode
		  go-ts-mode)
		 . eglot-ensure)

  :bind (:map eglot-mode-map
			  ("C-c l r" . eglot-rename)
			  ("C-<tab>" . eglot-code-actions))

  :config
  (add-hook 'project-find-functions #'config-lsp-kotlin-project-find)
  (mapc (lambda (program) (add-to-list 'eglot-server-programs program))
		'((python-ts-mode . ("pyright-langserver" "--stdio"))
		  ;; '((python-ts-mode . ("/Users/leemiyinghao/.pyenv/shims/pyright-langserver" "--stdio"))
		  ((go-mode go-ts-mode) . ("gopls" "serve"))
		  ((rust-ts-mode rust-mode) .
           ("rust-analyzer" :initializationOptions (:check (:command "clippy"))))
		  ((kotlin-ts-mode kotlin-mode) . ("kotlin-lsp" "--stdio"))
		  ((typescript-ts-mode tsx-ts-mode js-ts-mode json-ts-mode) . ("typescript-language-server" "--stdio")))))

(use-package eglot-booster
  :ensure (:host github :repo "jdtsmith/eglot-booster")
  :after eglot
  :config	(eglot-booster-mode))

(provide 'config-lsp)
;;; config-lsp.el ends here
