(add-to-list 'load-path "@SITELISP@")
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(require 'org-install)
(setq org-odt-data-dir "@SITEETC@")
