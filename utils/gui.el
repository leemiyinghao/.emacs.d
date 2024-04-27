(toggle-scroll-bar nil)
(pixel-scroll-precision-mode)
(define-key pixel-scroll-precision-mode-map (kbd "<prior>") 'xah-backward-block)
(define-key pixel-scroll-precision-mode-map (kbd "<next>") 'xah-forward-block)
(set-frame-font "Fira Code 14" nil t)

(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq-default line-spacing 2)
;; (setq browse-url-browser-function 'eww-browse-url)
;; (setq browse-url-browser-function 'xwidget-webkit-browse-url)

;; frame transparent
(set-frame-parameter (selected-frame) 'alpha '(95 95))
(add-to-list 'default-frame-alist '(alpha 95 95))
(add-to-list 'default-frame-alist '(internal-border-width . 8))

;; ;; maximized
;; (add-hook 'window-setup-hook 'toggle-frame-fullscreen t)

(use-package all-the-icons
  :defer t)

(use-package vertico-posframe
  :after vertico
  :config (vertico-posframe-mode 1))


;; ligature setting for Fira Code
(use-package ligature
  :straight (:host github :repo "mickeynp/ligature.el")
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable all Fira Code ligatures in programming modes
  (ligature-set-ligatures 'prog-mode '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\" "{-" "::"
                                       ":::" ":=" "!!" "!=" "!==" "-}" "----" "-->" "->" "->>"
                                       "-<" "-<<" "-~" "#{" "#[" "##" "###" "####" "#(" "#?" "#_"
                                       "#_(" ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*" "/**"
                                       "/=" "/==" "/>" "//" "///" "&&" "||" "||=" "|=" "|>" "^=" "$>"
                                       "++" "+++" "+>" "=:=" "==" "===" "==>" "=>" "=>>" "<="
                                       "=<<" "=/=" ">-" ">=" ">=>" ">>" ">>-" ">>=" ">>>" "<*"
                                       "<*>" "<|" "<|>" "<$" "<$>" "<!--" "<-" "<--" "<->" "<+"
                                       "<+>" "<=" "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<"
                                       "<~" "<~~" "</" "</>" "~@" "~-" "~>" "~~" "~~>" "%%"))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

(use-package eldoc-box
  :hook (prog-mode . eldoc-box-hover-mode))

(provide 'gui)
;;; gui.el ends here
