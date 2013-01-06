
;;; hm--view-process site-lisp configuration

(add-to-list 'load-path "@SITELISP@")

(autoload 'view-processes "view-process-mode"
  "Prints a list with processes in the buffer `view-process-buffer-name'.
   It calls the function `view-process-status' with default switches.
   As the default switches on BSD like systems the value of the variable
   `view-process-status-command-switches-bsd' is used.
   On System V like systems the value of the variable
   `view-process-status-command-switches-system-v' is used.
   IF the optional argument REMOTE-HOST is given, then the command will
   be executed on the REMOTE-HOST. If an prefix arg is given, then the
   function asks for the name of the remote host."
  t)
(setq View-process-status-command-switches-bsd "auxw")
