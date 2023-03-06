(use-package vertico
  :init
  (vertico-mode)
  (setq vertico-resize t)
  (setq vertico-cycle t)
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy) ; Correct file path when changed
  :config
  (custom-set-faces
   '(vertico-current ((t (:inherit highlight :underline t :weight semi-bold))))))
)
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

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; orderless
(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; consult
(use-package consult
  :bind
  (("C-M-s" . consult-ripgrep)))

;; embark
(use-package embark
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
  :after (embark consult)
  :demand t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; marginalia
(use-package marginalia
  :after vertico
  :ensure t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(use-package all-the-icons-completion
  :after (marginalia all-the-icons)
  :hook (marginalia-mode . all-the-icons-completion-marginalia-setup)
  :init
  (all-the-icons-completion-mode))
