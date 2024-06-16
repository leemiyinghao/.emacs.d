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
  (setq mouse-sel-mode t))


;; which key
(use-package which-key
  :diminish which-key-mode
  :config
  (which-key-mode))

;; guru-mode
(use-package guru-mode
  :config
  (setq guru-warn-only t)
  (guru-global-mode +1))

;; TRAMP remote development
(use-package tramp
  :config
  (setq enable-remote-dir-locals t)
  (let ((process-environment tramp-remote-process-environment))
    (setenv "ENV" "$HOME/.profile")
    (setq tramp-remote-process-environment process-environment))
  ;; Enable full-featured Dirvish over TRAMP on certain connections
  ;; https://www.gnu.org/software/tramp/#Improving-performance-of-asynchronous-remote-processes-1.
  (add-to-list 'tramp-connection-properties
               (list (regexp-quote "/sshx?:")
                     "direct-async-process" t))
  (setq tramp-chunksize 2000)
  (setq tramp-use-ssh-controlmaster-options nil))


;; multiple-cursors
(use-package multiple-cursors
  :defer t
  :bind ("C-c m" . 'mc/edit-lines))


;; autopair
(electric-pair-mode 1)

;; try for trying new packages
(use-package try
  :defer t)

;; emacs-libvterm
(use-package vterm
  :defer t)
(use-package multi-vterm
  :defer t
  :after vterm)

;; restart-emacs
(use-package restart-emacs
  :defer t)

;; centeralize buffer
(use-package olivetti
  :defer t
  :bind ("C-c o" . olivetti-mode))

;; display help-at-pt
(help-at-pt-set-timer)
(setq help-at-pt-display-when-idle t)

;; tty frontend
(use-package mistty
  :defer t
  :bind (:map mistty-prompt-map
			  ("M-<up>" . mistty-send-key)
			  ("M-<down>" . mistty-send-key)
			  ("M-<left>" . mistty-send-key)
			  ("M-<right>" . mistty-send-key))
  :config
  (set-face-foreground 'mistty-fringe-face "#8FBCBB")
  (setq mistty-allow-tramp-paths t))

;; breadcrumb
(use-package breadcrumb
  :straight (:host github :repo "joaotavora/breadcrumb" :files ("*.el"))
  :config
  (custom-set-faces '(breadcrumb-face ((t (:foreground "#616e88")))))
  (custom-set-variables '(breadcrumb-project-max-length 0.7))
  (breadcrumb-mode))

(use-package selectric-mode)

;; WakaTime
(use-package wakatime-mode
  :config (global-wakatime-mode)
  :diminish wakatime-mode)

(use-package flymake
  :defer t
  :hook
  (prog-mode . flymake-mode))

(use-package deadgrep
  :defer t)

(use-package kotlin-mode
  :defer t)

(use-package makefile-executor
  :defer t
  :hook
  ((makefile-mode makefile-ts-mode) . makefile-executor-mode))

(use-package git-timemachine
  :defer t)

(use-package casual
  :defer t)

(use-package cov
  :demand t
  :defer t
  :after (python projectile)
  :init
  (setq cov-coverage-mode t)
  (setq cov-fringe-symbol 'vertical-bar)
  (custom-set-faces
   '(cov-coverage-not-run-face ((t (:foreground "#bf616a"))))
   '(cov-coverage-run-face ((t (:foreground "#3b4252"))))
   '(cov-none-face ((t (:foreground "#d08770")))))

  :config
  (add-to-list 'cov-lcov-patterns (lambda (path file) (concat (projectile-project-root) "lcov.info")))
  :hook
  (python-mode . cov-mode)
  (python-ts-mode . cov-mode)
  (go-mode . cov-mode)
  (go-ts-mode . cov-mode))

(use-package treemacs
  :defer t
  :config
  (setq treemacs-width 30)
  (setq treemacs-show-hidden-files t)
  (setq treemacs-show-cursor t)
  (setq treemacs-show-cursor-in-non-empty-branches t)
  (setq treemacs-silent-refresh t)
  (setq treemacs-silent-filewatch t)
  (setq treemacs-silent-refresh t)
  (setq treemacs-silent-filewatch t)
  (treemacs-load-all-the-icons-with-workaround-font "Hermit")
  :bind
  ("C-<tab>" . treemacs)
  ("M-<tab>" . lsp-treemacs-symbols))
(use-package treemacs-projectile
  :after treemacs projectile)
(use-package treemacs-magit
  :after treemacs magit)

(provide 'config-qol)
;;; config-qol.el ends here
