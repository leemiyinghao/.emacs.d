;; company
(use-package company
  :config (setq company-show-numbers t
		company-selection-wrap-around t
		company-idle-delay 0
		company-minimum-prefix-length 1
		))
(global-company-mode)

(defun toggle-tabnine ()
  (interactive)
  (if (member #'company-tabnine company-backends)
      (progn
	(setq company-backends (remove #'company-tabnine company-backends))
	(message "Disabled company-tabnine."))
    (progn
      (add-to-list 'company-backends #'company-tabnine)
      (message "Enabled company-tabnine."))))

;; tabnine, enable by M-t
(use-package company-tabnine
  :ensure t
  ;; :init (add-to-list 'company-backends #'company-tabnine)
  :bind ("M-t" . 'toggle-tabnine))

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
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

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

;; auto save desktop.el
;; (desktop-save-mode 1)


;; try for trying new packages

(use-package try :ensure t)
