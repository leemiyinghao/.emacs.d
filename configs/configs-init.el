;; load packages

;; (load (expand-file-name "configs/qol.el" user-emacs-directory))
(require 'config-qol)
(require 'config-formatter)
(require 'config-xah-block)
(require 'config-lsp)
(require 'config-rust)
(require 'config-python)
(require 'config-golang)
(require 'config-magit)
(require 'config-compleseus)
(require 'config-org-mode)
(require 'config-markdown)
(require 'config-frontend)
(require 'config-debugger)
(require 'config-unison)
(require 'config-ollama)
(require 'config-k8s)
(require 'config-comint)
(require 'config-treesitter)
(require 'config-copilot)
(require 'config-spell)


;; lang misc

(use-package nginx-mode :ensure t :defer t)
(use-package dockerfile-mode :ensure t :defer t)
(use-package docker :ensure t :defer t)
(use-package ansible :ensure t :defer t)
(use-package json-mode :ensure t :defer t)
(use-package markdown-mode :ensure t :defer t)
(use-package kivy-mode :ensure t :defer t)
(use-package yaml-mode :ensure t :defer t)
(use-package lua-mode :ensure t :defer t)
(use-package php-mode :ensure t :defer t)
(use-package swift-mode :ensure t :defer t)

;; TRAMP remote PATH config
(setq enable-remote-dir-locals t)

;; TRAMP patch for magit, see https://github.com/magit/magit/issues/4720
(require 'config-tramp-patch)

(provide 'configs-init)
;;; init.el ends here
