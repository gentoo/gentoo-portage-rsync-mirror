
;;; dictionary site-lisp configuration

(add-to-list 'load-path "@SITELISP@")

(load "dictionary-init")

(global-set-key "\C-cs" 'dictionary-search)
(global-set-key "\C-cm" 'dictionary-match-words)
