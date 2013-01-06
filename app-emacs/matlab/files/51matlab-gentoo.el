
;;; matlab site-lisp configuration

(add-to-list 'load-path "@SITELISP@")

(autoload 'matlab-mode "matlab" "Enter Matlab mode." t)
(add-to-list 'auto-mode-alist '("\\.m\\'" . matlab-mode))
(autoload 'matlab-shell "matlab" "Interactive Matlab mode." t)

(autoload 'mlint-minor-mode "mlint" nil t)
(add-hook 'matlab-mode-hook (lambda () (mlint-minor-mode 1)))

(autoload 'tlc-mode "tlc" "tlc Editing Mode" t)
(add-to-list 'auto-mode-alist '("\\.tlc$" . tlc-mode))
(setq tlc-indent-function t)
