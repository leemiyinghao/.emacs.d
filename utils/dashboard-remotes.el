;;; dashboard-remotes.el --- SSH aliases on the dashboard -*- lexical-binding: t; -*-

(require 'dashboard-widgets)
(require 'tramp)

(defun my/dashboard-known-remotes (&optional file)
  "Return sorted SSH aliases from FILE or ~/.ssh/config as (NAME . TRAMP-PATH)."
  (let ((file (or file (expand-file-name "~/.ssh/config"))) remotes)
    (when (file-readable-p file)
      (with-temp-buffer
        (insert-file-contents-literally file)
        (goto-char (point-min))
        (let ((case-fold-search t))
          (while (re-search-forward "^[ \t]*Host[ \t]+\\([^#\n]+\\)" nil t)
            (dolist (alias (split-string (match-string 1) "[ \t]+" t))
              (when (and (not (string-match-p "[*!?]" alias))
                         (string-match-p (concat "\\`" tramp-host-regexp "\\'") alias))
                (push (cons alias
                            (tramp-make-tramp-file-name
                             (make-tramp-file-name :method tramp-default-method :host alias
                                                   :localname "~/")))
                      remotes)))))))
    (sort (delete-dups remotes) (lambda (a b) (string-lessp (car a) (car b))))))

(defun my/dashboard-connect-remote ()
  "Choose an SSH alias and open its home directory."
  (interactive)
  (let ((remotes (my/dashboard-known-remotes)))
    (unless remotes (user-error "No SSH aliases in ~/.ssh/config"))
    (dired (cdr (assoc (completing-read "Remote: " remotes nil t) remotes)))))

(defun my/dashboard-insert-remotes (list-size)
  "Insert LIST-SIZE SSH aliases without contacting them."
  (let ((remotes (my/dashboard-known-remotes)))
    (dashboard-insert-section
     "Remotes:" remotes list-size 'remotes (dashboard-get-shortcut 'remotes)
     `(lambda (&rest _) (dired ,(cdr el)))
     (propertize (car el) 'dashboard-path (cdr el)))
    (when (> (length remotes) list-size)
      (insert "\n    ")
      (widget-create 'item :tag "More remotes…"
                     :action (lambda (&rest _) (my/dashboard-connect-remote))
                     :button-face 'dashboard-items-face :mouse-face 'highlight
                     :button-prefix "" :button-suffix "" :format "%[%t%]"))))

(provide 'dashboard-remotes)
;;; dashboard-remotes.el ends here
