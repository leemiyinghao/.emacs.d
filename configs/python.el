(defun python-hook ()
  (use-package poetry
    :ensure t)
  (use-package pipenv
    :hook (python-mode . pipenv-mode)
    :init
    (setq
     pipenv-projectile-after-switch-function
     #'pipenv-projectile-after-switch-extended))
  (setq indent-tabs-mode t)
  (setq tab-width 4)
  (setq python-indent-offset 4))

(add-hook 'python-mode 'python-hook)


(use-package jupyter)

(use-package ein)

(use-package python-pytest
  :demand t
  :after python
  :bind (("C-c t" . python-pytest-dispatch)))
