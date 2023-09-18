;; load packages

(load (expand-file-name "configs/treesitter.el" user-emacs-directory))
(load (expand-file-name "configs/qol.el" user-emacs-directory))
(load (expand-file-name "configs/formatter.el" user-emacs-directory))
(load (expand-file-name "configs/xah-block.el" user-emacs-directory))
(load (expand-file-name "configs/lsp.el" user-emacs-directory))
(load (expand-file-name "configs/rust.el" user-emacs-directory))
(load (expand-file-name "configs/python.el" user-emacs-directory))
(load (expand-file-name "configs/magit.el" user-emacs-directory))
(load (expand-file-name "configs/compleseus.el" user-emacs-directory))
(load (expand-file-name "configs/org-mode.el" user-emacs-directory))
(load (expand-file-name "configs/markdown.el" user-emacs-directory))
(load (expand-file-name "configs/frontend.el" user-emacs-directory))
(load (expand-file-name "configs/dirvish.el" user-emacs-directory))
(load (expand-file-name "configs/projectile.el" user-emacs-directory))
(load (expand-file-name "configs/debugger.el" user-emacs-directory))


;; lang misc

(use-package nginx-mode :ensure t :defer t)
(use-package dockerfile-mode :ensure t :defer t)
(use-package json-mode :ensure t :defer t)
(use-package markdown-mode :ensure t :defer t)
(use-package kivy-mode :ensure t :defer t)
(use-package yaml-mode :ensure t :defer t)
(use-package lua-mode :ensure t :defer t)

;; TRAMP remote PATH config
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)
(setq enable-remote-dir-locals t)

;; TRAMP patch for magit, see https://github.com/magit/magit/issues/4720
(load (expand-file-name "configs/tramp-patch.el" user-emacs-directory))
