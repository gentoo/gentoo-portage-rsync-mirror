
;;; lua-mode site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(autoload 'lua-mode "lua-mode" "Mode for editing Lua scripts" t)
(setq auto-mode-alist
      (append '(("\\.lua$" . lua-mode))
              auto-mode-alist))
(setq lua-default-application "/usr/bin/lua")
