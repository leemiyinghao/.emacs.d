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
											(?[ . ?])))))

(add-hook 'javascript-ts-mode-hook #'config-javascript--setup)
(add-hook 'html-mode-hook #'config-html--setup)

(defun flymake-eslint-enable-current-project ()
  "Enable flymake-eslint with current project eslint binary, if available."
  (interactive)

  (let* ((pj-root (project-root (project-current)))
		 (looking-for-binary (concat pj-root "node_modules/.bin/eslint")))
	(when (and pj-root (file-exists-p looking-for-binary)))
	(setq-local flymake-eslint-project-root pj-root)
	(setq-local flymake-eslint-executable-name looking-for-binary))
  (flymake-eslint-enable))

(use-package flymake-eslint
  :ensure t
  :config
  (add-hook 'typescript-ts-mode-hook #'flymake-eslint-enable-current-project)
  (add-hook 'tsx-ts-mode-hook #'flymake-eslint-enable-current-project))

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
