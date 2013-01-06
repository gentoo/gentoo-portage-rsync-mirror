(add-to-list 'load-path "@SITELISP@")
(mapc (function (lambda (f) (autoload f "mairix" nil t)))
      '(mairix-search
	mairix-widget-search
	mairix-update-database
	mairix-search-from-this-article
	mairix-search-thread-this-article
	mairix-widget-search-based-on-article
	mairix-save-search
	mairix-use-saved-search
	mairix-edit-saved-searches))
