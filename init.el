;; init essential
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)
(package-initialize)
(require 'use-package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; load ui stuff
(load (expand-file-name "ui.el" user-emacs-directory))
(load (expand-file-name "theme.el" user-emacs-directory))

;; setup backup directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq create-lockfiles nil)

(load (expand-file-name "configs/init.el" user-emacs-directory))

(if (display-graphic-p)
    (load (expand-file-name "gui.el" user-emacs-directory))
  (load (expand-file-name "terminal.el" user-emacs-directory)))

(when (string= system-type "darwin")
  (load (expand-file-name "macos.el" user-emacs-directory)))

(load (expand-file-name "keybind.el" user-emacs-directory))
