(tool-bar-mode -1)
(menu-bar-mode -1)
;(toggle-scroll-bar -1)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(add-to-list 'default-frame-alist '(font . "Fira Code" ))
(set-face-attribute 'default t :font "Fira Code")

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3") 

(package-initialize)
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes
   (quote
    ("ba3c5da197000aaf2f5514bef814b4d8bf1b6de7309b9fcd682ec26aa6a16fd2" default)))
 '(font-use-system-font t)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (highlight-thing yaml-mode tabbar tabbar-ruler neotree nginx-mode company-nginx material-theme swiper golden-ratio-scroll-screen adaptive-wrap autopair counsel js2-mode react-snippets emmet-mode rjsx-mode ivy company-web web-mode flycheck json-mode flymake-json bash-completion company-fuzzy company company-jedi magit py-isort elpy elpl wiki twittering-mode ssh smooth-scrolling rust-mode ox-ioslide nyan-mode multiple-cursors moz markdown-preview-eww markdown-mode+ kivy-mode jdee java-snippets java-imports enh-ruby-mode edbi-sqlite circe auto-install auto-complete-nxml ac-html-bootstrap ac-emacs-eclim 2048-game))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;(setq default-frame-alist '((background-color . "black")(foreground-color . "gray")))


(add-to-list 'load-path (expand-file-name "~/.emacs.d/auto-install"))
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")

"autopair"
(use-package autopair)
(autopair-global-mode)

"golden-ratio-scroll-screen"
(use-package golden-ratio-scroll-screen)
(global-set-key [remap scroll-down-command] 'golden-ratio-scroll-screen-down)
(global-set-key [remap scroll-up-command] 'golden-ratio-scroll-screen-up)

"ivy"
(use-package ivy
  :ensure t
  :diminish (ivy-mode . "")
  :config
  (ivy-mode 1)
  (setq ivy-use-virutal-buffers t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-height 6)
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-count-format "%d/%d")
  (setq ivy-re-builders-alist
        `((t . ivy--regex-ignore-order)))
  )
(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file)))
(use-package swiper
  :ensure t
  :bind (("C-s" . swiper))
  )


"company"
;; Enable company globally for all mode
(global-company-mode)

;; Reduce the time after which the company auto completion popup opens
(setq company-idle-delay 0.2)

;; Reduce the number of characters before company kicks in
(setq company-minimum-prefix-length 1)


;; flycheck section
(use-package flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

"python settings"

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

        (autoload 'bash-completion-dynamic-complete
          "bash-completion"
          "BASH completion hook")
        (add-hook 'shell-dynamic-complete-functions
          'bash-completion-dynamic-complete)


;; web relative
(use-package web-mode
  :ensure t
  :mode ("\\.html\\'" "\\.vue\\'")
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-css-colorization t)
  (setq web-mode-content-types-alist
        '(("vue" . "\\.vue\\'")))
  (use-package company-web
    :ensure t)
  (add-hook 'web-mode-hook (lambda()
                             (cond ((equal web-mode-content-type "html")
                                    (my/web-html-setup))
                                   ((member web-mode-content-type '("vue"))
                                    (my/web-vue-setup))
                                   )))
  )
(defun my/web-vue-setup()
  "Setup for js related."
  (message "web-mode use vue related setup")
  (setup-tide-mode)
  (prettier-js-mode)
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (flycheck-select-checker 'javascript-eslint)
  (my/use-eslint-from-node-modules)
  (add-to-list (make-local-variable 'company-backends)
               '(comany-tide company-web-html company-css company-files))
  )
(defun my/use-eslint-from-node-modules ()
  "Use local eslint from node_modules before global."
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))
    ))
(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)

;; react jsx
(use-package rjsx-mode
  :ensure t
  :mode ("\\.js\\'")
  :config
  (add-hook 'rjsx-mode-hook (lambda()
			      (flycheck-add-mode 'javascript-eslint 'rjsx-mode)
			      (my/use-eslint-from-node-modules)
			      (flycheck-select-checker 'javascript-eslint)
			      ))
  )
(use-package emmet-mode
  :ensure t
  :hook (web-mode css-mode scss-mode sgml-mode rjsx-mode)
  :config
  (add-hook 'emmet-mode-hook (lambda()
			       (setq emmet-indent-after-insert t))))
(use-package mode-local
      :ensure t
      :config
      (setq-mode-local rjsx-mode emmet-expand-jsx-className? t)
      (setq-mode-local web-mode emmet-expand-jsx-className? nil)
);
;(use-package react-snippets
;  :ensure t)
(add-hook 'rjsx-mode-hook #'setup-tide-mode)

;; rust
;; Set path to racer binary
(setq racer-cmd "/usr/local/bin/racer")

;; Set path to rust src directory
(setq racer-rust-src-path "/home/leemiyinghao/.rust/src/")

;; Load rust-mode when you open `.rs` files
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

;; Setting up configurations when you load rust-mode
(add-hook 'rust-mode-hook
	  '(lambda ()
	     ;; Enable racer
	     (racer-activate)

	     ;; Hook in racer with eldoc to provide documentation
	     (racer-turn-on-eldoc)

	     ;; Use flycheck-rust in rust-mode
	     (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

	     ;; Use company-racer in rust mode
	     (set (make-local-variable 'company-backends) '(company-racer))

	     ;; Key binding to jump to method definition
	     (local-set-key (kbd "M-.") #'racer-find-definition)

	     ;; Key binding to auto complete and indent
	     (local-set-key (kbd "TAB") #'racer-complete-or-indent)))
(use-package yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-hook 'yaml-mode-hook
	  '(lambda ()
	     (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

; nginx-mode
(require 'nginx-mode)

; sudo-edit
(defun sudo-edit (&optional arg)
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file(as root): ")))
    (find-alternate-file (concat "/sudo:root@localhost:"
                                 buffer-file-name))))

(use-package neotree)
(global-set-key [f8] 'neotree-toggle)


(use-package highlight-thing)
(global-highlight-thing-mode)
