;; keybind.el --- Keybindings lexical binding -*- lexical-binding: t; -*-

(global-set-key (kbd "C-c l g g") 'xref-find-definitions)
(global-set-key (kbd "C-c l g r") 'xref-find-references)

;; use Super-{<up>, <down>, <left>, <right>} to move between windows
(global-set-key (kbd "s-<up>") 'windmove-up)
(global-set-key (kbd "s-<down>") 'windmove-down)
(global-set-key (kbd "s-<left>") 'windmove-left)
(global-set-key (kbd "s-<right>") 'windmove-right)

(provide 'keybind)
;;; keybind.el ends here
