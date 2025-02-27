; dape for debugging

;; (use-package dape
;;   :elpaca nil
;;   :preface
;;   (setq dape-key-prefix "\C-x\C-a")

;;   :hook
;;   ((kill-emacs . dape-breakpoint-save)
;;    (after-init . dape-breakpoint-load))

;;   :init
;;   (setq dape-buffer-window-arrangement 'gud)

;;   :config
;;   (dape-breakpoint-global-mode)
;;   (add-hook 'dape-compile-compile-hooks 'kill-buffer)

;;   (setq dape-cwd-fn 'project-root))

(provide 'config-debugger)
;;; config-debugger.el ends here
