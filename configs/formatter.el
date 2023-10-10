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
  (setf (alist-get 'beautysh apheleia-formatters)
	'("beautysh" "-"))
  (setf (alist-get 'sh-mode apheleia-mode-alist)
	'(beautysh))
  (setq apheleia-remote-algorithm 'remote))
