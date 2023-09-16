(setq major-mode-remap-alist
      '((yaml-mode . yaml-ts-mode)
	(bash-mode . bash-ts-mode)
	(json-mode . json-ts-mode)
	(css-mode . css-ts-mode)
	(python-mode . python-ts-mode)))

(use-package treesit-auto
  :defer t
  :config
  (global-treesit-auto-mode))

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
