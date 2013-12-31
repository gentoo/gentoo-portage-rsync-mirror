(add-to-list 'load-path "@SITELISP@")
(autoload 'jasmin-mode "jasmin"
  "Major mode for editing Jasmin Java bytecode assembler files." t)
(or (assoc "\\.j\\'" auto-mode-alist)
    (setq auto-mode-alist (cons '("\\.j\\'" . jasmin-mode) auto-mode-alist)))
