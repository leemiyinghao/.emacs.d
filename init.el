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

;; load ui stuff
(load (expand-file-name "theme.el" user-emacs-directory))
(load (expand-file-name "ui.el" user-emacs-directory))

(if (display-graphic-p)
    (load (expand-file-name "gui.el" user-emacs-directory))
  (load (expand-file-name "terminal.el" user-emacs-directory)))

;; setup backup directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq create-lockfiles nil)

(load (expand-file-name "configs/init.el" user-emacs-directory))

(let ((local-configs (expand-file-name "local-config/init.el" user-emacs-directory)))
  (when (file-exists-p local-configs)
    (load-file local-configs)))


(when (string= system-type "darwin")
  (load (expand-file-name "macos.el" user-emacs-directory)))
(when (string= system-type "linux")
  (load (expand-file-name "linux.el" user-emacs-directory)))

(load (expand-file-name "keybind.el" user-emacs-directory))
