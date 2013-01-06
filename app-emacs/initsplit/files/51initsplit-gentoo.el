
;;; initsplit site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(autoload 'initsplit-split-user-init-file "initsplit")
(autoload 'initsplit-byte-compile-files "initsplit")

;; Avoid clobbering the kill ring
;; (see http://www.emacswiki.org/cgi-bin/wiki?InitSplit)

(defadvice initsplit-split-customizations (around do-the-initsplit act)
  "Don't clobber the `kill-ring' when writing customizations."
  (let ((orig-kill-ring kill-ring))
    (unwind-protect
	ad-do-it
      (setq kill-ring orig-kill-ring))))
