(use-package kubernetes
  :defer t
  :commands (kubernetes-overview)
  :config
  (setq kubernetes-poll-frequency 3600
        kubernetes-redraw-frequency 3600))
(use-package kubedoc
  :defer t)
(use-package kubectx-mode
  :defer t)
(use-package kubernetes-helm
  :defer t)
(use-package kubel
  :defer t)
