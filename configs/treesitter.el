;; (setq major-mode-remap-alist
;;       '((yaml-mode . yaml-ts-mode)
;; 	(bash-mode . bash-ts-mode)
;; 	(json-mode . json-ts-mode)
;; 	(css-mode . css-ts-mode)
;; 	(python-mode . python-ts-mode)))

;; (use-package treesit-auto
;;   :defer t
;;   :config
;;   (global-treesit-auto-mode))

(use-package combobulate
  :straight (:host github :repo "mickeynp/combobulate")
  :bind (("C-M-<prior>" . combobulate-navigate-previous)
	 ("C-M-<next>" . combobulate-navigate-next)
	 :map combobulate-key-map
	 ("M-<left>" . left-word)
	 ("M-<right>" . right-word))
         (js-ts-mode . combobulate-mode)
         (css-ts-mode . combobulate-mode)
         (yaml-ts-mode . combobulate-mode)
         (json-ts-mode . combobulate-mode)
         (typescript-ts-mode . combobulate-mode)
         (tsx-ts-mode . combobulate-mode)))
(use-package tree-sitter
  :config (global-tree-sitter-mode))
(use-package tree-sitter-langs)

(use-package msgu
  :straight (:host github :repo "jcs-elpa/msgu"
                   :files (:defaults "langs/*.el")))
;; ts-docstr
(use-package ts-docstr 
  :straight (ts-docstr :type git :host github :repo "emacs-vs/ts-docstr"
                       :files (:defaults "langs/*.el")))

