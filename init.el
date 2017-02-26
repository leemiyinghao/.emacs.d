(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;Auto-Complete
(add-to-list 'load-path "~/.emacs.d/auto-complete")
(add-to-list 'load-path "~/.emacs.d/popup")
(add-to-list 'load-path "~/.emacs.d/fuzzy")
(add-to-list 'load-path "~/.emacs.d/nginx-mode")
(require 'nginx-mode)
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")

(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(custom-set-variables
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#ad7fa8" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes
   (quote
    ("ba3c5da197000aaf2f5514bef814b4d8bf1b6de7309b9fcd682ec26aa6a16fd2" default)))
 '(font-use-system-font t)
 '(inhibit-startup-screen t))
(custom-set-faces
 )
(setq default-frame-alist '((background-color . "black")(foreground-color . "gray")))

(add-to-list 'load-path "~/.emacs.d/php-mode")
(require 'php-mode)


(setq tags-file-name "~/.emacs.d/TAGS")

(add-to-list 'ac-sources 'ac-source-etags)


(add-to-list 'load-path (expand-file-name "~/.emacs.d/auto-install"))
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")

(add-to-list 'load-path "~/.emacs.d/el-get/auto-complete-etags")
(defun my-c-mode-common-hook-func ()
  (interactive)
  "Function to be called when entering into c-mode."
  (when (and (require 'auto-complete nil t) (require 'auto-complete-config nil t))
    (auto-complete-mode t)
    (make-local-variable 'ac-sources)
    (setq ac-auto-start 2)
    (setq ac-sources '(ac-source-words-in-same-mode-buffers
		       ac-source-dictionary))
    (when (require 'auto-complete-etags nil t)
      (add-to-list 'ac-sources 'ac-source-etags)
      (setq ac-etags-use-document t))))
(defun quick-compile ()
  "A quick compile funciton for C++"
  (interactive)
  (compile (concat "g++ " (buffer-name (current-buffer)) " -g -pg")))
(global-set-key [(f9)] 'quick-compile)
(global-set-key [(f10)] 'gdb)
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook-func)


(defun my-java-mode-common-hook-func ()
  (custom-set-variables
   '(eclim-eclipse-dirs '("~/usr/bin/eclipse"))
   '(eclim-executable "~/nonStandard/eclipse/eclim"))
  (require 'eclim)
  (global-eclim-mode))
(add-hook 'java-mode-common-hook 'my-java-mode-common-hook-func)
