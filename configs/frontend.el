(use-package vue-mode
  :defer t)

(use-package svelte-mode
  :defer t)

(add-to-list 'auto-mode-alist '("\\.mjs\\'" . javascript-mode))


(use-package js-comint
  :defer t
  :config (setq inferior-js-program-command "node"))

(use-package ts-comint
  :defer t)
