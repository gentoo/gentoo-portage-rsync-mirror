
;;; jam-mode site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(autoload 'jam-mode "jam-mode" "Mode for editing Jam files" t)
(setq auto-mode-alist
      (append '(("\\.jam$" . jam-mode)
                ("[Jj]ambase$" . jam-mode)
                ("[Jj]amfile$" . jam-mode)
                ("[Jj]amrules$" . jam-mode))
              auto-mode-alist))
