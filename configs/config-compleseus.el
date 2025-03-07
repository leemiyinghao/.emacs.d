;;; config-compleseus.el --- -*- lexical-binding: t -*-

(use-package vertico
  :init
  (vertico-mode)
  (setq vertico-resize t)
  (setq vertico-cycle t)
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy) ; Correct file path when changed
  :config
  (custom-set-faces
   '(vertico-current ((t (:inherit highlight :underline t :weight semi-bold))))))

(advice-add #'vertico--format-candidate :around
            (lambda (orig cand prefix suffix index _start)
              (setq cand (funcall orig cand prefix suffix index _start))
              (concat
               (if (= vertico--index index)
                   (propertize "» " 'face 'vertico-current)
                 "  ")
               cand)))

(defun kb/basic-remote-try-completion (string table pred point)
  (and (vertico--remote-p string)
       (completion-basic-try-completion string table pred point)))
(defun kb/basic-remote-all-completions (string table pred point)
  (and (vertico--remote-p string)
       (completion-basic-all-completions string table pred point)))
(add-to-list 'completion-styles-alist
             '(basic-remote           ; Name of `completion-style'
               kb/basic-remote-try-completion kb/basic-remote-all-completions nil))

(savehist-mode 1)

;; orderless
(use-package orderless
  :defer t
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; consult
(use-package consult
  :after org
  :bind
  (("C-M-s" . consult-ripgrep)
   ("C-s" . consult-line)
   ("C-c b" . consult-buffer)
   ;; generic
   ("C-c s" . consult-imenu)
   ("C-c e e" . consult-flymake)
   ("C-x p f" . consult-fd)
   :map org-mode-map
   ("C-c s" . consult-org-heading)))

;; consult extensions
(use-package consult-dash
  :defer t
  :bind (("M-s d" . consult-dash))
  :config
  (consult-customize consult-dash :initial (thing-at-point 'symbol)))

(use-package consult-eglot
  :defer t
  :bind (("M-s l" . consult-eglot-symbols)))

;; embark
(use-package embark
  :defer t
  :bind
  (("C-." . embark-act)
   ("C-;" . embark-dwim)
   ("C-h B" . embark-bindings))
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))


;; embark-consult
(use-package embark-consult
  :defer t
  :after (embark consult)
  :demand t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; marginalia
(use-package marginalia
  :defer t
  :after vertico
  :ensure t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(use-package all-the-icons-completion
  :defer t
  :after (marginalia all-the-icons)
  :hook (marginalia-mode . all-the-icons-completion-marginalia-setup)
  :init
  (all-the-icons-completion-mode))

(use-package corfu
  :ensure (corfu :files (:defaults "extensions/*")
                 :includes (corfu-info corfu-history))
  :config
  (setq corfu-popupinfo-delay 0)
  (setq corfu-preview-current t)
  (setq corfu-auto nil)
  (setq corfu-quit-no-match 'separator)
  (corfu-popupinfo-mode)
  (setq tab-always-indent 'complete)
  :init
  (global-corfu-mode t))

(use-package popon
  :ensure (:type git :repo "https://codeberg.org/akib/emacs-popon.git"))

(use-package corfu-doc
  :ensure (:host github :repo "galeo/corfu-doc"))

(use-package corfu-terminal
  :ensure (:repo "https://codeberg.org/akib/emacs-corfu-terminal.git"))

(unless (display-graphic-p)
  (corfu-terminal-mode +1))

(use-package corfu-doc-terminal
  :ensure (:repo "https://codeberg.org/akib/emacs-corfu-doc-terminal.git"))


(unless (display-graphic-p)
  (corfu-doc-terminal-mode +1))



(use-package cape
  ;; Bind dedicated completion commands
  ;; Alternative prefix keys: C-c p, M-p, M-+, ...
  :bind (("C-c p p" . completion-at-point) ;; capf
         ("C-c p t" . complete-tag)        ;; etags
         ("C-c p d" . cape-dabbrev)        ;; or dabbrev-completion
         ("C-c p h" . cape-history)
         ("C-c p f" . cape-file)
         ("C-c p k" . cape-keyword)
         ("C-c p s" . cape-symbol)
         ("C-c p a" . cape-abbrev)
         ("C-c p l" . cape-line)
         ("C-c p w" . cape-dict)
         ("C-c p \\" . cape-tex)
         ("C-c p _" . cape-tex)
         ("C-c p ^" . cape-tex)
         ("C-c p &" . cape-sgml)
         ("C-c p r" . cape-rfc1345))
  :init
  ;; Add `completion-at-point-functions', used by `completion-at-point'.
  ;; NOTE: The order matters!
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block))

(setq completion-cycle-threshold 3)
(setq tab-always-indent 'complete)

(use-package kind-icon
  :elpaca nil
  :ensure t
  :defer t
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default)
  (kind-icon-default-style 
   '(:padding 0 :stroke 0 :margin 0 :radius 0 :height 0.5 :scale 1))
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package consult-tramp
  :defer t
  :ensure (:host github :repo "Ladicle/consult-tramp"))

(provide 'config-compleseus)
;;; config-compleseus.el ends here
