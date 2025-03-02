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

(add-hook 'tsx-ts-mode-hook #'config-html--setup)
(add-hook 'tsx-ts-mode-hook #'config-javascript--setup)
(add-hook 'typescript-ts-mode-hook #'config-javascript--setup)
(add-hook 'javascript-ts-mode-hook #'config-javascript--setup)
(add-hook 'html-mode-hook #'config-html--setup)

(provide 'config-web)

;;; config-web.el ends here
