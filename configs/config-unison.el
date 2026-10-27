;;; config-unison.el --- Unison sync helper -*- lexical-binding: t; -*-

(defgroup unison nil
  "Unison sync helper."
  :group 'communication
  :prefix "unison-remote-")

(defcustom unison-remote-profile nil
  "Profile name for unison to execute."
  :group 'unison
  :type 'string)

(defun unison-call-sync (profile-name)
  "Sync PROFILE-NAME asynchronously, coalescing saves during a running sync."
  (let* ((name (concat "unison-" profile-name))
         (process (get-process name)))
    (if (and process (process-live-p process))
        (process-put process 'pending t)
      (let ((default-directory (expand-file-name "~/"))
            (buffer (get-buffer-create (format "*unison %s*" profile-name))))
        (with-current-buffer buffer
          (let ((inhibit-read-only t)) (erase-buffer)))
        (setq process
              (make-process :name name :buffer buffer
                            :command (list "unison" profile-name)
                            :connection-type 'pipe :noquery t
                            :sentinel #'unison-sync-sentinel))
        (process-put process 'profile profile-name)
        (message "Syncing %s..." profile-name)))))

(defun unison-sync-sentinel (process _event)
  "Report PROCESS completion and sync again if files were saved meanwhile."
  (when (memq (process-status process) '(exit signal))
    (let ((profile (process-get process 'profile)))
      (if (and (eq (process-status process) 'exit)
               (zerop (process-exit-status process)))
          (progn
            (message "Unison: files have been synced for %s." profile)
            (when (process-get process 'pending)
              (unison-call-sync profile)))
        (message "Unison: sync failed for %s. Check %s; retry with M-x unison-do-sync."
                 profile (format "*unison %s*" profile))))))


(defun unison-sync ()
  (if (stringp unison-remote-profile)
      (unison-call-sync unison-remote-profile)))

(defun unison-do-sync ()
  (interactive)
  (unison-sync))

(add-hook 'after-save-hook 'unison-sync)

(provide 'config-unison)
;;; config-unison.el ends here
