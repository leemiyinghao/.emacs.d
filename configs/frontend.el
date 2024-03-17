(use-package vue-mode
  :defer t)

(use-package svelte-mode)

(add-to-list 'auto-mode-alist '("\\.mjs\\'" . javascript-mode))


(use-package js-comint
  :config (setq inferior-js-program-command "node"))
