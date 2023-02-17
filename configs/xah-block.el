(defun xah-forward-block (&optional n)
  "Move cursor beginning of next text block.
A text block is separated by blank lines.
This command similar to `forward-paragraph', but this command's behavior is the same regardless of syntax table.
URL `http://ergoemacs.org/emacs/emacs_move_by_paragraph.html'
Version 2016-06-15"
  (interactive "p")
  (let ((n (if (null n) 1 n)))
    (re-search-forward "\n[\t\n ]*\n+" nil "NOERROR" n)))

(defun xah-backward-block (&optional n)
  "Move cursor to previous text block.
See: `xah-forward-block'
URL `http://ergoemacs.org/emacs/emacs_move_by_paragraph.html'
Version 2016-06-15"
  (interactive "p")
  (let ((n (if (null n) 1 n))
	($i 1))
    (while (<= $i n)
      (if (re-search-backward "\n[\t\n ]*\n+" nil "NOERROR")
	  (progn (skip-chars-backward "\n\t "))
	(progn (goto-char (point-min))
	       (setq $i n)))
      (setq $i (1+ $i)))))
(global-set-key (kbd "<prior>") 'xah-backward-block)
(global-set-key (kbd "<next>") 'xah-forward-block)
(global-set-key (kbd "M-p") 'xah-backward-block)
(global-set-key (kbd "M-n") 'xah-forward-block)
