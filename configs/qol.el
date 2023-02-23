;; company
(use-package company :ensure t)
(global-company-mode)
(setq company-idle-delay 0.0)
(setq company-minimum-prefix-length 1)

(use-package company-tabnine
  :ensure t
  :init (add-to-list 'company-backends #'company-tabnine))

;; (use-package company-yasnippet)

;; ;; yasnippet
;; (use-package yasnippet
;;   :ensure t
;;   ;; :hook
;;   ;; (prog-mode . yas-minor-mode)
;;   :init (add-to-list 'company-backends #'company-yasnippet)
;;   ;; :config
;;   add company-yasnippet to company-backends
;;   (defun company-mode/backend-with-yas (backend)
;;     (if (and (listp backend) (member 'company-yasnippet backend))
;; 	backend
;;       (append (if (consp backend) backend (list backend))
;;               '(:with company-yasnippet))))
;;   (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
;;   ;; unbind <TAB> completion
;;   (define-key yas-minor-mode-map [(tab)]        nil)
;;   (define-key yas-minor-mode-map (kbd "TAB")    nil)
;;   (define-key yas-minor-mode-map (kbd "<tab>")  nil)
;;   :bind
;;   (:map yas-minor-mode-map ("M-<tab>" . yas-expand)))

;; (use-package yasnippet-snippets
;;   :ensure t
;;   :after yasnippet)
;; ;; (use-package yasnippet
;; ;;   :config
;; ;;   (yas-global-mode 1))
;; ;; (use-package yasnippet-snippets)


;; Enable mouse support
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] (lambda ()
                              (interactive)
                              (scroll-down 1)))
  (global-set-key [mouse-5] (lambda ()
                              (interactive)
                              (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t)
)


;; which key
(use-package which-key :ensure t)
(which-key-mode)

;; guru-mode
(use-package guru-mode :ensure t)
(guru-global-mode +1)
(setq guru-warn-only t)

;; TRAMP remote development
(use-package tramp
  :ensure t
  :config
  (setq enable-remote-dir-locals t)
  (let ((process-environment tramp-remote-process-environment))
    (setenv "ENV" "$HOME/.profile")
    (setq tramp-remote-process-environment process-environment)))

;; nyan-mode
(use-package nyan-mode
  :ensure t
  :config
  (nyan-mode 1))

;; neotree
(use-package neotree :ensure t)
(global-set-key [f8] 'neotree-toggle)

; sudo-edit
(defun sudo-edit (&optional arg)
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file(as root): ")))
    (find-alternate-file (concat "/sudo:root@localhost:"
                                 buffer-file-name))))

;; ripgrep
(use-package ripgrep :ensure t)

;; multiple-cursors
(use-package multiple-cursors :ensure t)


;; autopair
(electric-pair-mode 1)


