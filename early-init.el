(setenv "LSP_USE_PLISTS" "true")
(when (eq system-type 'darwin)
  (setenv "SDKROOT"
          (car (process-lines "xcrun" "--sdk" "macosx" "--show-sdk-path")))
  (let ((gcc-runtime
         (car (file-expand-wildcards
               "/opt/homebrew/lib/gcc/current/gcc/*/*"))))
    (when gcc-runtime
      (setq native-comp-driver-options
            (list "-Wl,-w" (concat "-L" gcc-runtime))))))
(setq package-enable-at-startup nil)
(setq read-process-output-max (* 10 1024 1024)) ;; 10mb
(setq gc-cons-threshold 200000000)
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 16 1024 1024))))
(setq byte-compile-warnings '(not obsolete))
(setq warning-suppress-log-types '((comp) (bytecomp)))
(setq native-comp-async-report-warnings-errors 'silent)
(setq inhibit-startup-echo-area-message (user-login-name))
(setq frame-resize-pixelwise t)
