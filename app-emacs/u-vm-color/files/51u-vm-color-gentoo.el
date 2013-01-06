
;;; u-vm-color site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(autoload 'u-vm-color-summary-mode "u-vm-color"
  "Configure `font-lock-keywords' and add some hooks for vm-buffers." t)
(autoload 'u-vm-color-fontify-buffer "u-vm-color" "Fontifies mail-buffers." t)
(autoload 'u-vm-color-fontify-buffer-even-more "u-vm-color")

(add-hook 'vm-summary-mode-hook 'u-vm-color-summary-mode)
(add-hook 'vm-select-message-hook 'u-vm-color-fontify-buffer)
