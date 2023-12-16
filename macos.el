(setq dired-use-ls-dired nil)
(setq ls-lisp-use-insert-directory-program nil)
(require 'ls-lisp)
(setq insert-directory-program "gls")
;; mac
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(setq pixel-scroll-precision-use-momentum t)
