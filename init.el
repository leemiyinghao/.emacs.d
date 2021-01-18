(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;Auto-Complete
;(add-to-list 'load-path "~/.emacs.d/auto-complete")
;(add-to-list 'load-path "~/.emacs.d/popup")
;(add-to-list 'load-path "~/.emacs.d/fuzzy")


;(add-to-list 'load-path "~/.emacs.d/nginx-mode")
;(require 'nginx-mode)
;(require 'auto-complete-config)
;(ac-config-default)
;(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(require 'use-package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#ad7fa8" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes
   (quote
    ("ba3c5da197000aaf2f5514bef814b4d8bf1b6de7309b9fcd682ec26aa6a16fd2" default)))
 '(font-use-system-font t)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (company-fuzzy company company-jedi magit py-isort elpy elpl wiki twittering-mode ssh smooth-scrolling rust-mode ox-ioslide nyan-mode multiple-cursors moz markdown-preview-eww markdown-mode+ kivy-mode jdee java-snippets java-imports enh-ruby-mode edbi-sqlite circe auto-install auto-complete-nxml ac-html-bootstrap ac-emacs-eclim 2048-game))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(setq default-frame-alist '((background-color . "black")(foreground-color . "gray")))

;(add-to-list 'load-path "~/.emacs.d/php-mode")
;(require 'php-mode)


;(setq tags-file-name "~/.emacs.d/TAGS")

;(add-to-list 'ac-sources 'ac-source-etags)


(add-to-list 'load-path (expand-file-name "~/.emacs.d/auto-install"))
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")

;(add-to-list 'load-path "~/.emacs.d/el-get/auto-complete-etags")
;; (defun my-c-mode-common-hook-func ()
;;   (interactive)
;;   "Function to be called when entering into c-mode."
;;   (when (and (require 'auto-complete nil t) (require 'auto-complete-config nil t))
;;     (auto-complete-mode t)
;;     (make-local-variable 'ac-sources)
;;     (setq ac-auto-start 2)
;;     (setq ac-sources '(ac-source-words-in-same-mode-buffers
;; 		       ac-source-dictionary))
;;     (when (require 'auto-complete-etags nil t)
;;       (add-to-list 'ac-sources 'ac-source-etags)
;;       (setq ac-etags-use-document t))))
;; (defun quick-compile ()
;;   "A quick compile funciton for C++"
;;   (interactive)
;;   (compile (concat "g++ " (buffer-name (current-buffer)) " -g -pg")))
;; (global-set-key [(f9)] 'quick-compile)
;; (global-set-key [(f10)] 'gdb)
;; (add-hook 'c-mode-common-hook 'my-c-mode-common-hook-func)


;; (defun my-java-mode-common-hook-func ()
;;   (custom-set-variables
;;    '(eclim-eclipse-dirs '("~/usr/bin/eclipse"))
;;    '(eclim-executable "~/nonStandard/eclipse/eclim"))
;;   (require 'eclim)
;;   (global-eclim-mode))
;; (add-hook 'java-mode-common-hook 'my-java-mode-common-hook-func)

"python settings"
;(use-package company-jedi
;  :ensure t
;  :config
;  (add-hook 'python-mode-hook 'jedi:setup)
;  (add-hook 'python-mode-hook (lambda ()
;                                (add-to-list (make-local-variable 'company-backends)                                             'company-jedi)))
;  )

(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable))
(add-hook 'elpy-mode-hook (lambda ()
  (add-hook 'before-save-hook 'elpy-black-fix-code nil t))
 0)
(require 'py-isort)
(add-hook 'before-save-hook 'py-isort-before-save)

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
