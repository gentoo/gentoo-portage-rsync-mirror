(require 'cedet "@SITELISP@/common/cedet")
(when (boundp 'image-load-path)
  (add-to-list 'image-load-path "@SITEETC@/common/icons" t)
  (add-to-list 'image-load-path "@SITEETC@/cogre" t)
  (add-to-list 'image-load-path "@SITEETC@/speedbar" t))
(setq srecode-map-load-path
      (list "@SITEETC@/srecode/templates"
	    "@SITEETC@/ede/templates"
	    "@SITEETC@/cogre/templates"
	    (expand-file-name "~/.srecode")))

;; If you wish to customize CEDET, you will need to follow the
;; directions in the INSTALL (installed in the documentation) file and
;; customize your ~/.emacs /before/ site-gentoo is loaded.
