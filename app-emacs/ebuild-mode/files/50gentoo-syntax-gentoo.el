(add-to-list 'load-path "@SITELISP@")
(autoload 'ebuild-mode "gentoo-syntax"
  "Major mode for Portage .ebuild and .eclass files." t)
(autoload 'eselect-mode "gentoo-syntax" "Major mode for .eselect files." t)
(autoload 'gentoo-newsitem-mode "gentoo-syntax"
  "Major mode for Gentoo GLEP 42 news items." t)

(add-to-list 'auto-mode-alist
	     '("\\.\\(ebuild\\|eclass\\|eblit\\)\\'" . ebuild-mode))
(add-to-list 'auto-mode-alist '("\\.eselect\\'" . eselect-mode))
(add-to-list 'auto-mode-alist
	     '("/[0-9]\\{4\\}-[01][0-9]-[0-3][0-9]-.+\\.[a-z]\\{2\\}\\.txt\\'"
	       . gentoo-newsitem-mode))
(add-to-list 'interpreter-mode-alist '("runscript" . sh-mode))
(modify-coding-system-alist
 'file "\\.\\(ebuild\\|eclass\\|eblit\\|eselect\\)\\'" 'utf-8)
