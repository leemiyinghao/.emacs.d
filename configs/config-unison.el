(defgroup unison nil
  "Unison sync helper."
  :group 'communication
  :prefix "unison-remote-")

(defcustom unison-remote-profile nil
  "Profile name for unison to execute."
  :group 'unison
  :type 'string)

(defun unison-call-sync (profile-name)
  (message "Syncing %s..." profile-name)
  (with-temp-buffer
    (if (eq (call-process "unison" nil (current-buffer) t profile-name) 0)
	(progn (message "Unison: files have been sync for %s." profile-name))
    (let ((error-buffer (get-buffer-create "*unison errors*")))
      (progn
	(insert-into-buffer error-buffer)
	(display-buffer error-buffer))))))


(defun unison-sync ()
  (if (stringp unison-remote-profile)
      (unison-call-sync unison-remote-profile)))

(defun unison-do-sync ()
  (interactive)
  (unison-sync))

(add-hook 'after-save-hook 'unison-sync)

(provide 'config-unison)
;;; config-unison.el ends here
