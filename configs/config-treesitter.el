(defun treesit-setup-install-grammars ()
  "Install Tree-sitter grammars if they are absent."
  (interactive)
  (dolist (grammar
           '((css . ("https://github.com/tree-sitter/tree-sitter-css"))
             (html . ("https://github.com/tree-sitter/tree-sitter-html"))
             (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript"))
             (json . ("https://github.com/tree-sitter/tree-sitter-json"))
             (python . ("https://github.com/tree-sitter/tree-sitter-python"))
             (toml "https://github.com/tree-sitter/tree-sitter-toml")
             (tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" nil "tsx/src"))
             (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" nil "typescript/src"))
			 (jsdoc . ("https://github.com/tree-sitter/tree-sitter-jsdoc"))
             (yaml . ("https://github.com/ikatyang/tree-sitter-yaml"))
			 (bash . ("https://github.com/tree-sitter/tree-sitter-bash"))
			 (go . ("https://github.com/tree-sitter/tree-sitter-go"))
			 (gomod . ("https://github.com/camdencheek/tree-sitter-go-mod"))
			 (rust . ("https://github.com/tree-sitter/tree-sitter-rust"))
			 (java . ("https://github.com/tree-sitter/tree-sitter-java"))
			 (c . ("https://github.com/tree-sitter/tree-sitter-c"))
			 (c-sharp . ("https://github.com/tree-sitter/tree-sitter-c-sharp"))
			 (scala . ("https://github.com/tree-sitter/tree-sitter-scala"))
			 (commonlisp . ("https://github.com/tree-sitter-grammars/tree-sitter-commonlisp"))
			 (dockerfile . ("https://github.com/camdencheek/tree-sitter-dockerfile"))
			 (elixir . ("https://github.com/elixir-lang/tree-sitter-elixir"))
			 (lua . ("https://github.com/tree-sitter-grammars/tree-sitter-lua"))
			 (make . ("https://github.com/tree-sitter-grammars/tree-sitter-make"))
			 (r . ("https://github.com/r-lib/tree-sitter-r"))
			 (ruby . ("https://github.com/tree-sitter/tree-sitter-ruby"))
			 (cpp . ("https://github.com/tree-sitter/tree-sitter-cpp"))
			 (vue . ("https://github.com/tree-sitter-grammars/tree-sitter-vue"))
			 (kotlin . ("https://github.com/fwcd/tree-sitter-kotlin"))
			 (graphql . ("https://github.com/bkegley/tree-sitter-graphql"))))
    (add-to-list 'treesit-language-source-alist grammar)
    (unless (treesit-language-available-p (car grammar))
      (message "installing %s" (car grammar))
      (treesit-install-language-grammar (car grammar)))))

(treesit-setup-install-grammars)
(use-package scala-ts-mode)
(use-package makefile-ts-mode
  :ensure (:host github :repo "nverno/makefile-ts-mode"))
(use-package r-ts-mode
  :ensure (:host github :repo "nverno/r-ts-mode"))
(use-package kotlin-ts-mode)
(use-package graphql-ts-mode
  :elpaca nil)

(setq major-mode-remap-alist
      '((yaml-mode . yaml-ts-mode)
		(bash-mode . bash-ts-mode)
		(sh-mode . bash-ts-mode)
		(cmake-mode . cmake-ts-mode)
		(json-mode . json-ts-mode)
		(js-json-mode . json-ts-mode)
		(javascript-mode . js-ts-mode)
		(js-mode . js-ts-mode)
		(js2-mode . js-ts-mode)
		(css-mode . css-ts-mode)
		(typescript-mode . typescript-ts-mode)
		(ts-mode . typescript-ts-mode)
		(tsx-mode . tsx-ts-mode)
		(python-mode . python-ts-mode)
		(yaml-mode . yaml-ts-mode)
		(go-mode . go-ts-mode)
		(c++-mode . c++-ts-mode)
		(ruby-mode . ruby-ts-mode)
		(r-mode . r-ts-mode)
		(makefile-mode . makefile-ts-mode)
		(dockerfile-mode . dockerfile-ts-mode)
		(csharp-mode . csharp-ts-mode)
		(c-mode . c-ts-mode)
		(java-mode . java-ts-mode)
		(rust-mode . rust-ts-mode)
		(kotlin-mode . kotlin-ts-mode)
		(graphql-mode . graphql-ts-mode)))

(use-package cognitive-complexity
  :ensure (:host github :repo "abougouffa/cognitive-complexity")
  :hook (prog-mode . (lambda () (cognitive-complexity-mode 1))))

(use-package treesitter-context
  :ensure (:host github :repo "zbelial/treesitter-context.el")
  :bind (("C-'" . treesitter-context-fold-toggle)))

(provide 'config-treesitter)
;;; config-treesitter.el ends here
