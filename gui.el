(toggle-scroll-bar nil)
(add-to-list 'default-frame-alist
             '(font . "Fira Code 14"))

(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq-default line-spacing 2)
;; (add-to-list 'default-frame-alist '(internal-border-width . 15))

;; frame transparent
(set-frame-parameter (selected-frame) 'alpha '(95 95))
(add-to-list 'default-frame-alist '(alpha 95 95))

;; maximized
(add-hook 'window-setup-hook 'toggle-frame-fullscreen t)

(use-package all-the-icons
  :defer t)

(use-package vertico-posframe
  :after vertico
  :config (vertico-posframe-mode 1))

