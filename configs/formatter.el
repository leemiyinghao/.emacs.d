(use-package apheleia
  :defer t
  :bind (("C-c l = =" . apheleia-format-buffer))
  :config
  (setf (alist-get 'python-mode apheleia-mode-alist)
	'(isort black))
  (setf (alist-get 'python-ts-mode apheleia-mode-alist)
	'(isort black))
  (setf (alist-get 'lisp-mode apheleia-mode-alist)
	'(lisp-indent))
  (setq apheleia-remote-algorithm 'remote))
