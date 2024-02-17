(setq major-mode-remap-alist
      '((yaml-mode . yaml-ts-mode)
	(bash-mode . bash-ts-mode)
	(json-mode . json-ts-mode)
	(css-mode . css-ts-mode)
	(python-mode . python-ts-mode)
	(go-mode . go-ts-mode)))

;; (use-package treesit-auto
;;   :defer t
;;   :config
;;   (global-treesit-auto-mode))

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

