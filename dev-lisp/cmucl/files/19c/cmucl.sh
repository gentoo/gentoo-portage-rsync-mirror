#!/bin/sh

if [ ! -f /usr/share/common-lisp/source/common-lisp-controller/common-lisp-controller.lisp ] ; then
  cat <<EOF
$0: cannot find the common-lisp-controller source.
EOF
  exit 0
fi

IMAGE=/usr/lib/cmucl/lisp.core
DIR=cmucl

case $1 in
    rebuild)
	    echo $0 rebuilding...
	    shift
	    while [ ! -z "$1" ] ; do
		echo rebuilding $1
		/usr/bin/lisp -core $IMAGE -eval "
(let ((*gc-verbose* nil)
      (*compile-print* nil)
      (*compile-progress* nil)
      (*compile-verbose*  nil)
      (*require-verbose* nil)
      (*load-verbose* nil))
  (load \"/etc/common-lisp/cmucl/site-init.lisp\"))
(let ((*gc-verbose* nil)
      (*compile-print* t)
      (*compile-progress* nil)
      (*compile-verbose*  t)
      (*require-verbose* t)
      (*load-verbose* t)
      (mk::*load-source-if-no-binary* nil)
      (mk::*bother-user-if-no-binary* nil)
      (mk::*compile-during-load* t))

    (handler-case
       (progn
	 (with-compilation-unit (:optimize '((inhibit-warnings 3)))
          (common-lisp-controller:compile-library :$1))
         (unix:unix-exit 0))
      (error (e)
        (ignore-errors (format t \"~&Built Error: ~A~%\" e))
	(finish-output)
        (unix:unix-exit 1)))))" -nositeinit -noinit -batch -quiet || exit 1
		shift
 	    done 
	    ;;
     remove)
	    echo $0 removing packages...
	    shift
	    while [ ! -z "$1" ] ; do
		rm -rf "/usr/lib/common-lisp/$DIR/$1"
		shift
 	    done
	    rmdir /usr/lib/common-lisp/$DIR 2> /dev/null 
	    ;;
    install-defsystem|install-clc)
    	    echo installing the clc...
	    ( cd /usr/lib/cmucl
	     [ -f $IMAGE ] && rm -f $IMAGE
	     /usr/bin/lisp  \
	       -core ${IMAGE%.core}-dist.core -load /usr/lib/cmucl/install-clc.lisp \
	       -nositeinit -noinit -batch -quiet  && \
               mv new-lisp.core $IMAGE || (echo FAILED ; ln ${IMAGE%.core}-dist.core $IMAGE ) )
    	    ;;
    remove-defsystem|remove-clc)
     	    [ -f $IMAGE ] && rm -f $IMAGE
    	    ;;
    make-user-image)
    	    if [ ! -f $1 ] ; then 
	      echo Cannot find file $1 to load and dump!
	      exit 321
	    fi
	    /usr/bin/lisp -core $IMAGE -eval "
(load \"$1\")
    ;;
    ;; Enable the garbage collector.  But first fake it into thinking that
    ;; we don't need to garbage collect.  The save-lisp is going to call
    ;; purify so any garbage will be collected then.
#-gengc (setf lisp::*need-to-collect-garbage* nil)
(gc-on)
    ;;
    ;; Save the lisp.
(setf ext:*batch-mode* nil)
(save-lisp #p\"home:lisp.core\")" -nositeinit -noinit -batch -quiet && echo New image created
	    ;;
    *)
	    echo $0 unkown command $1
	    echo known commands: install-clc, remove-clc,rebuild and remove
	    exit 1
	    ;;
esac

exit 0
