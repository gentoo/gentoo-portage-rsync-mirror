;;; -*- Mode: LISP; Package: CL-USER -*-
;;;
;;; Copyright Peter Van Eynde, 2001
;;;
;;; License: LGPL v2
;;;
(in-package "COMMON-LISP-USER")

(unless (ignore-errors
          (load "/usr/share/common-lisp/source/common-lisp-controller/common-lisp-controller.lisp"))
  (unix:unix-exit 1))

;; (unless (ignore-errors
          (common-lisp-controller:init-common-lisp-controller 
           "/usr/lib/common-lisp/cmucl/"
           :version 3)
;;           t)
;;   (format t "~%Error during init of common-lisp-controller~%")
;;   (unix:unix-exit 1))

(in-package :common-lisp-controller)

(defun send-clc-command (command package)
  (let ((process
         (ext:run-program "/usr/bin/clc-send-command"
                          (list
                           (ecase command
                             (:recompile "recompile")
                             (:remove "remove"))
                           (format nil "~A" package)
			   "cmucl"
                           "--quiet")
                          :wait t)))
    (if (= (ext:process-exit-code process)
           0)
        ;; no error
        (values)
        (error "An error happend during ~A of ~A for ~A~%Please see /usr/share/doc/common-lisp-controller/REPORTING-BUGS.gz"
               (ecase command
                 (:recompile "recompilation")
                 (:remove "removal"))
               package
	       "cmucl"))))

(in-package "COMMON-LISP-USER")

(unless (ignore-errors
          ;; it loaded, configure it for common-lisp-controller use:
          (format t "~%Saving to new-lisp.core...")
          (ext:gc :full t)       
          (setf ext:*batch-mode* nil)
          (ext:save-lisp "new-lisp.core" 
                         :purify t))
  (unix:unix-exit 1))

