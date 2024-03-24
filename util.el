(defun merge-list-to-list (dst src)
  "Merges content of the 2nd list with the 1st one"
  (set dst
       (append (eval dst) src)))
