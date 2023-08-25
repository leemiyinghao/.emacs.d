(toggle-scroll-bar nil)
(add-to-list 'default-frame-alist
             '(font . "Fira Code 14"))

(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq-default line-spacing 2)

;; modeline settings
'(mode-line ((t (:underline nil :overline nil :box (:line-width 8 :color "#353644" :style nil) :foreground "white" :background "#353644"))))
'(mode-line-buffer-id ((t (:weight bold))))
'(mode-line-emphasis ((t (:weight bold))))
'(mode-line-highlight ((((class color) (min-colors 88)) (:box (:line-width 2 :color "grey40" :style released-button))) (t (:inherit (highlight)))))
'(mode-line-inactive ((t (:weight light :underline nil :overline nil :box (:line-width 8 :color "#565063" :style nil) :foreground "white" :background "#565063" :inherit (mode-line)))))

;; tab bar beautify
'(tab-bar ((t (:inherit mode-line))))
'(tab-bar-tab ((t (:inherit mode-line :foreground "white"))))
'(tab-bar-tab-inactive ((t (:inherit mode-line-inactive :foreground "black"))))

;; frame transparent
(set-frame-parameter (selected-frame) 'alpha '(95 95))
(add-to-list 'default-frame-alist '(alpha 95 95))

;; maximized
(add-hook 'window-setup-hook 'toggle-frame-maximized t)

(use-package all-the-icons)
(use-package nerd-icons)
