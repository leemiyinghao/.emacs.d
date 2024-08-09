;;; config-spell.el --- Spell checking -*- lexical-binding: t; -*-

(use-package flyspell
  :ensure nil
  :hook ((text-mode . flyspell-mode)
		 (prog-mode . flyspell-prog-mode))
  :config
  (setq ispell-program-name "aspell"
		ispell-extra-args '("--sug-mode=ultra"
							"--lang=en_US"
							"--run-together"
							"--run-together-limit=16"
							"--run-together-min=2")
	    ispell-dictionary "en_US"))

(use-package consult-flyspell
  :after flyspell
  :bind (("C-c e f" . consult-flyspell)))

(use-package flyspell-correct
  :after flyspell
  :bind (:map flyspell-mode-map ("C-;" . flyspell-correct-wrapper)))

(provide 'config-spell)
;;; config-spell.el ends here
;;; typo
