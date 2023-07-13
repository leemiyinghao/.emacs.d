(defun toggle-tabnine ()
  (interactive)
  (if (member #'tabnine-completion-at-point completion-at-point-functions)
      (progn
	(setq completion-at-point-functions (remove #'tabnine-completion-at-point completion-at-point-functions))
	(message "Disabled tabnine-capf."))
    (progn
      (add-to-list 'completion-at-point-functions #'tabnine-completion-at-point t)
      (message "Enabled tabnine-capf."))))


;; tabnine, enable by M-t
(use-package tabnine-capf
  :straight (:host github :repo "50ways2sayhard/tabnine-capf" :files ("*.el" "*.sh"))
  :hook (kill-emacs . tabnine-capf-kill-process)
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
(use-package multiple-cursors
  :ensure t
  :bind ("C-c m" . 'mc/edit-lines))


;; autopair
(electric-pair-mode 1)

;; try for trying new packages
(use-package try :ensure t)

;; emacs-libvterm
(use-package vterm :ensure t)
(use-package multi-vterm)

;; restart-emacs
(use-package restart-emacs)
