
;;; xrdb-mode site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(autoload 'xrdb-mode "xrdb-mode" "Mode for editing X resource files" t)
(setq auto-mode-alist
      (append '(("\\.Xdefaults$"    . xrdb-mode)
                ("\\.Xenvironment$" . xrdb-mode)
                ("\\.Xresources$"   . xrdb-mode)
                ("\\.ad$"         . xrdb-mode))
              auto-mode-alist))
