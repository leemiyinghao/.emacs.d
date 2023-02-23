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


(use-package python-black
  :demand t
  :after python
  :bind (("C-c l = =" . python-black-buffer)
	 ("C-c l = r" . python-black-region)))
(use-package python-isort
  :after python
  :bind (("C-c i =" . python-isort-buffer)))
