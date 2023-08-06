(use-package apheleia
  :after python
  :bind (("C-c l = =" . apheleia-format-buffer))
  :config
  (setf (alist-get 'python-mode apheleia-mode-alist)
	'(isort black))
  (setf (alist-get 'lisp-mode apheleia-mode-alist)
	'(lisp-indent))
  (setq apheleia-remote-algorithm 'remote))
