
;;; sawfish site-lisp configuration 

(add-to-list 'load-path "@SITELISP@")
(autoload 'sawfish-mode "sawfish" "Autoload for sawfish-mode" t)
(autoload 'sawfish-interaction "sawfish" "Autoload for sawfish-interaction" t)
(autoload 'sawfish-console "sawfish" "Autoload for sawfish-console" t)
(add-to-list 'auto-mode-alist '("\\.sawfishrc$"  . sawfish-mode))
(add-to-list 'auto-mode-alist '("\\.jl$"         . sawfish-mode))
(add-to-list 'auto-mode-alist '("\\.sawfish/rc$" . sawfish-mode))
