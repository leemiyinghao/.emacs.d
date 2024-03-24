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
             (yaml . ("https://github.com/ikatyang/tree-sitter-yaml"))
	     (bash . ("https://github.com/tree-sitter/tree-sitter-bash"))
	     (go . ("https://github.com/tree-sitter/tree-sitter-go"))
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
	     (kotlin . ("https://github.com/fwcd/tree-sitter-kotlin"))))
    (add-to-list 'treesit-language-source-alist grammar)
    (unless (treesit-language-available-p (car grammar))
      (message "installing %s" (car grammar))
      (treesit-install-language-grammar (car grammar)))))

(treesit-setup-install-grammars)
(use-package scala-ts-mode)
(use-package makefile-ts-mode
  :straight (:host github :repo "nverno/makefile-ts-mode"))
(use-package r-ts-mode
  :straight (:host github :repo "nverno/r-ts-mode"))
(use-package kotlin-ts-mode)
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
	(python-mode . python-ts-mode)
	(yaml-mode . yaml-ts-mode)
	(go-mode . go-ts-mode)
	(vue-mode . vue-ts-mode)
	(c++-mode . c++-ts-mode)
	(ruby-mode . ruby-ts-mode)
	(r-mode . r-ts-mode)
	(makefile-mode . makefile-ts-mode)
	(dockerfile-mode . dockerfile-ts-mode)
	(csharp-mode . csharp-ts-mode)
	(c-mode . c-ts-mode)
	(java-mode . java-ts-mode)
	(rust-mode . rust-ts-mode)
	(kotlin-mode . kotlin-ts-mode)))

(use-package combobulate
  :straight (:host github :repo "mickeynp/combobulate")
  :preface
  (setq combobulate-key-prefix "C-c o")
  :hook
  (((yaml-ts-mode
     bash-ts-mode
     cmake-ts-mode
     json-ts-mode
     js-json-ts-mode
     js-ts-mode
     js2-ts-mode
     css-ts-mode
     python-ts-mode
     yaml-ts-mode
     go-ts-mode
     vue-ts-mode
     c++-ts-mode
     ruby-ts-mode
     r-ts-mode
     makefile-ts-mode
     dockerfile-ts-mode
     csharp-ts-mode
     c-ts-mode
     java-ts-mode
     rust-ts-mode
     kotlin-ts-mode
     yaml-ts-mode)
    . combobulate-mode)))

(use-package msgu
  :straight (:host github :repo "jcs-elpa/msgu"
                   :files (:defaults "langs/*.el")))

