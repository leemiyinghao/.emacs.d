(use-package ellama)

(defun ellama-write-python-docstr ()
  "Ask ellama to write docstr in selected region or current buffer."
  (interactive)
  (let ((input "You are a experienced developer, add or update python doc string for each function definitions without any explaination, only provide the doc string without any code or any modification of code, make it as simple and concise as possible, in format of:
{summary of function}

{overall description}

Args:
    - {parameter}({parameter type}): {parameter description}

Returns:
- {return type}: {return description}

Raises:
- {exception type}: {exception description}"))
    (if (region-active-p)
	(ellama-context-add-selection)
      (ellama-context-add-buffer (buffer-name (current-buffer))))
    (ellama-chat input)))

(defun ellama-write-go-docstr ()
  "Ask ellama to write docstr in selected region or current buffer."
  (interactive)
  (let ((input "You are a experienced developer, add or update golang doc string for each function definitions without any explaination, only provide the doc string without any code or any modification of code, make it as simple and concise as possible"))
    (if (region-active-p)
	(ellama-context-add-selection)
      (ellama-context-add-buffer (buffer-name (current-buffer))))
    (ellama-chat input)))

(provide 'config-ollama)
;;; config-ollama.el ends here
