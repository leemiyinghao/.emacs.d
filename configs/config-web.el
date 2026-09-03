;; config-web.el --- Web development configuration
;; Bind typescript-ts-mode to .ts files

;;; Code:

(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))

(defun config-html--setup ()
  "Setup web development configuration for HTML."
  (setq-local electric-pair-pairs
			  (append electric-pair-pairs '((?< . ?>)))))

(defun config-javascript--setup ()
  "Setup web development configuration for JavaScript."
  (setq-local electric-pair-pairs
			  (append electric-pair-pairs '((?` . ?`)
											(?' . ?')
											(?{ . ?})
											(?\[ . ?\])))))

(add-hook 'javascript-ts-mode-hook #'config-javascript--setup)
(add-hook 'html-mode-hook #'config-html--setup)

(require 'project)
(require 'subr-x)

(defun flymake-jsts--project-binary (linter binary)
  "Return the best available path for BINARY for LINTER."
  (or (and (file-name-absolute-p binary)
           (file-executable-p binary)
           binary)
      (when-let* ((root (flymake-jsts/get-process-cwd linter (current-buffer)))
                  (local-binary (expand-file-name
                                 (format "node_modules/.bin/%s" binary)
                                 root)))
        (when (file-executable-p local-binary)
          local-binary))
      (executable-find binary)))

(defun flymake-jsts--enable-linter-if-available (linter enable-fn)
  "Enable LINTER with ENABLE-FN when its binary is available."
  (when-let* ((binary-name (cdr (assq linter flymake-jsts-executable-name-alist)))
              (binary-path (flymake-jsts--project-binary linter binary-name)))
    (unless (local-variable-p 'flymake-jsts-executable-name-alist)
      (setq-local flymake-jsts-executable-name-alist
                  (copy-tree flymake-jsts-executable-name-alist)))
    (message "flymake-jsts: enabling %s with %s" linter binary-path)
    (setf (alist-get linter flymake-jsts-executable-name-alist) binary-path)
    (funcall enable-fn)
    t))

(defun flymake-jsts-enable ()
  "Enable one available flymake-jsts linter for the current buffer."
  (unless (or (flymake-jsts--enable-linter-if-available 'oxlint #'flymake-jsts-oxlint-enable)
              (flymake-jsts--enable-linter-if-available 'eslint #'flymake-jsts-eslint-enable))
    (message "flymake-jsts: no available oxlint/eslint binary found")))

(use-package flymake-jsts
  :straight '(flymake-jsts :type git :host github :repo "orzechowskid/flymake-jsts" :branch "main")
  :config
  (add-hook 'typescript-ts-mode-hook #'flymake-jsts-enable)
  (add-hook 'tsx-ts-mode-hook #'flymake-jsts-enable))


(use-package jtsx
  :ensure t
  :mode (("\\.jsx?\\'" . jtsx-jsx-mode)
         ("\\.tsx\\'" . jtsx-tsx-mode)
         ("\\.ts\\'" . jtsx-typescript-mode))
  :commands jtsx-install-treesit-language
  :hook ((jtsx-jsx-mode . hs-minor-mode)
         (jtsx-tsx-mode . hs-minor-mode)
         (jtsx-typescript-mode . hs-minor-mode))
  :custom
  (jtsx-enable-jsx-electric-closing-element t)
  (jtsx-enable-electric-open-newline-between-jsx-element-tags t)
  (jtsx-enable-jsx-element-tags-auto-sync t)
  (jtsx-enable-all-syntax-highlighting-features t)
  :config
  (defun jtsx-bind-keys-to-mode-map (mode-map)
    "Bind keys to MODE-MAP."
    (define-key mode-map (kbd "C-c C-j") 'jtsx-jump-jsx-element-tag-dwim)
    (define-key mode-map (kbd "C-c j o") 'jtsx-jump-jsx-opening-tag)
    (define-key mode-map (kbd "C-c j c") 'jtsx-jump-jsx-closing-tag)
    (define-key mode-map (kbd "C-c j r") 'jtsx-rename-jsx-element)
    (define-key mode-map (kbd "C-c <down>") 'jtsx-move-jsx-element-tag-forward)
    (define-key mode-map (kbd "C-c <up>") 'jtsx-move-jsx-element-tag-backward)
    (define-key mode-map (kbd "C-c C-<down>") 'jtsx-move-jsx-element-forward)
    (define-key mode-map (kbd "C-c C-<up>") 'jtsx-move-jsx-element-backward)
    (define-key mode-map (kbd "C-c C-S-<down>") 'jtsx-move-jsx-element-step-in-forward)
    (define-key mode-map (kbd "C-c C-S-<up>") 'jtsx-move-jsx-element-step-in-backward)
    (define-key mode-map (kbd "C-c j w") 'jtsx-wrap-in-jsx-element)
    (define-key mode-map (kbd "C-c j u") 'jtsx-unwrap-jsx)
    (define-key mode-map (kbd "C-c j d n") 'jtsx-delete-jsx-node)
    (define-key mode-map (kbd "C-c j d a") 'jtsx-delete-jsx-attribute)
    (define-key mode-map (kbd "C-c j t") 'jtsx-toggle-jsx-attributes-orientation)
    (define-key mode-map (kbd "C-c j h") 'jtsx-rearrange-jsx-attributes-horizontally)
    (define-key mode-map (kbd "C-c j v") 'jtsx-rearrange-jsx-attributes-vertically))
  
  (defun jtsx-bind-keys-to-jtsx-jsx-mode-map ()
    (jtsx-bind-keys-to-mode-map jtsx-jsx-mode-map))

  (defun jtsx-bind-keys-to-jtsx-tsx-mode-map ()
    (jtsx-bind-keys-to-mode-map jtsx-tsx-mode-map))

  (add-hook 'jtsx-jsx-mode-hook 'jtsx-bind-keys-to-jtsx-jsx-mode-map)
  (add-hook 'jtsx-tsx-mode-hook 'jtsx-bind-keys-to-jtsx-tsx-mode-map)
  (setq-local lsp-enabled-clients '(vtsls)))

(provide 'config-web)

;;; config-web.el ends here
