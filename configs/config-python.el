;;; config-python.el --- Python configuration -*- lexical-binding: t -*-

(use-package python-pytest
  :demand t
  :defer t
  :after python
  :bind (("C-c t" . python-pytest-dispatch)))

(use-package flymake-ruff
  :defer t
  :hook ((python-mode . flymake-ruff-load)
		 (python-ts-mode . flymake-ruff-load)))

(provide 'config-python)
;;; config-python.el ends here
