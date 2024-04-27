;; init essential
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)
(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; (setq straight-use-package-by-default t)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
;; (require 'straight)
;; (setq straight-use-package-by-default t)


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)
;; silence compile warning
(setq native-comp-async-report-warnings-errors t)

(use-package benchmark-init
  :ensure t
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

(add-to-list 'load-path (expand-file-name "utils/" user-emacs-directory))

;; load utils
(require 'util)

;; load ui stuff
(require 'theme)
(require 'ui)

(if (display-graphic-p)
    (require 'gui)
  (require 'terminal))

;; setup backup directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq create-lockfiles nil)

(use-package diminish)
(add-to-list 'load-path (expand-file-name "configs/" user-emacs-directory))
(require 'configs-init)

(let ((local-configs (expand-file-name "local-config/init.el" user-emacs-directory)))
  (when (file-exists-p local-configs)
    (load-file local-configs)))


(when (string= system-type "darwin")
  (require 'macos))
(when (string= system-type "linux")
  (require 'linux))

(require 'keybind)
(put 'scroll-left 'disabled nil)
(put 'erase-buffer 'disabled nil)
