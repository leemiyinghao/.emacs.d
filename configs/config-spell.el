;;; config-spell.el --- Spell checking -*- lexical-binding: t; -*-

(add-hook 'text-mode-hook 'flyspell-mode)
(setq ispell-program-name "aspell"
	  ispell-extra-args '("--sug-mode=ultra"
						  "--lang=en_US"
						  "--run-together"
						  "--run-together-limit=16"
						  "--run-together-min=2")
	  ispell-dictionary "en_US")
(use-package consult-flyspell
  :after flyspell
  :bind (("C-c e f" . consult-flyspell)))

(provide 'config-spell)
;;; config-spell.el ends here
;;; typo
