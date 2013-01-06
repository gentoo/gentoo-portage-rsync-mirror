;;;; -*- Mode: Lisp; Package: CL-USER -*-
;;;; Copyright (c) 2004 Kevin M. Rosenberg
;;;; GNU GPL v2 license

(in-package #:cl-user)

(handler-case
    (load "/usr/share/common-lisp/source/common-lisp-controller/common-lisp-controller.lisp")
  (error (e)
    (format t "Error during loading of common-lisp-controller.lisp: ~A~%" e)))

(handler-case
    (common-lisp-controller:init-common-lisp-controller-v4 "clisp")
  (error (e)
    (format t "Error during init-common-lisp-controller-v4: ~A~%" e)))
