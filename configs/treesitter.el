(setq major-mode-remap-alist
      '((yaml-mode . yaml-ts-mode)
	(bash-mode . bash-ts-mode)
	(sh-mode . bash-ts-mode)
	(cmake-mode . cmake-ts-mode)
	(json-mode . json-ts-mode)
	(javascript-mode . js-ts-mode)
	(js-mode . js-ts-mode)
	(css-mode . css-ts-mode)
	(python-mode . python-ts-mode)
	(yaml-mode . yaml-ts-mode)
	(go-mode . go-ts-mode)
	(php-mode . php-ts-mode)))

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

