(use-package go-translate
  :config
  (setq gts-translate-list '(("en" "zh-tw")))

  ;; (setq gts-default-translator (gts-translator :engines (gts-google-engine)))

  (setq gts-default-translator
	(gts-translator
	 ;; :picker (gts-prompt-picker)
	 :engines (list (gts-google-engine))
	 :render (gts-buffer-render))))

(provide 'config-translate)
;;; config-translate.el ends here