;; config-web.el --- Web development configuration
;; Bind typescript-ts-mode to .ts files

;;; Code:

(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))
(provide 'config-web)

;;; config-web.el ends here
