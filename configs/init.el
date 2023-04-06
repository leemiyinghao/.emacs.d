;; load packages

(load (expand-file-name "configs/qol.el" user-emacs-directory))
(load (expand-file-name "configs/xah-block.el" user-emacs-directory))
(load (expand-file-name "configs/lsp.el" user-emacs-directory))
(load (expand-file-name "configs/rust.el" user-emacs-directory))
(load (expand-file-name "configs/python.el" user-emacs-directory))
(load (expand-file-name "configs/magit.el" user-emacs-directory))
(load (expand-file-name "configs/compleseus.el" user-emacs-directory))
(load (expand-file-name "configs/org-mode" user-emacs-directory))


;; lang misc

(use-package nginx-mode :ensure t)
(use-package dockerfile-mode :ensure t)
(use-package json-mode :ensure t)
(use-package markdown-mode :ensure t)
(use-package kivy-mode :ensure t)
(use-package yaml-mode :ensure t)
(use-package lua-mode :ensure t)
