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


(use-package jupyter
  :defer t)

(use-package ein
  :defer t)

(use-package python-pytest
  :demand t
  :defer t
  :after python
  :bind (("C-c t" . python-pytest-dispatch)))

(use-package cov
  :demand t
  :defer t
  :after python
  :init
  (setq cov-coverage-mode t)
  (setq cov-fringe-symbol 'vertical-bar)
  (custom-set-faces
   '(cov-coverage-not-run-face ((t (:foreground "#bf616a"))))
   '(cov-coverage-run-face ((t (:foreground "#3b4252")))))
  :hook (python-mode . cov-mode))
