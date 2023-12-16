(use-package kubernetes
  :commands (kubernetes-overview)
  :config
  (setq kubernetes-poll-frequency 3600
        kubernetes-redraw-frequency 3600))
(use-package kubedoc)
(use-package kubectx-mode)
(use-package kubernetes-helm)
