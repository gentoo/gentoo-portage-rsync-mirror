#!/bin/sh
# Copyright (c) 2002 Kevin M. Rosenberg
# GNU GPL v2 license
 
if [ ! -f /usr/share/common-lisp/source/common-lisp-controller/common-lisp-controller.lisp ] ; then
  echo "*** Can't find common-lisp-controller.lisp ***" >&2
  echo "Please report this as a bug" &>2
  exit 1
fi

clisp_dir=/usr/lib/clisp
clc_lib_dir=/usr/lib/common-lisp/clisp

builder=/usr/bin/clisp
old_mem=$clisp_dir/full/lispinit.mem
new_mem=$clisp_dir/full/lispinit-new.mem
clean_mem=$clisp_dir/full/lispinit-clean.mem

lisp_error()
{
    echo "Error running $builder" >&2
    exit 1
}

mem_error()
{
    echo "Error moving new lisp image $new_mem" >&2
    exit 1
}


case $1 in
    rebuild)
	echo $0 Rebuilding packages...
	shift
	while [ -x $builder ] && [ ! -z "$1" ] ; do
	    echo ...rebuilding $1
	    $builder -norc -q -M $old_mem -x "
(let ((*compile-print* nil)
      (*compile-progress* nil)
      (*compile-verbose*  nil)
      (*require-verbose* nil)
      (*load-verbose* nil) 
      (mk::*load-source-if-no-binary* nil)
      (mk::*bother-user-if-no-binary* nil)
      (mk::*compile-during-load* t))
   (handler-case
      (progn
         (c-l-c:compile-library (quote $1))
         (ext:exit 0)
       )
    (error (e)
      (ignore-errors (format t \"~&Build error: ~A~%\" e))
      (finish-output)
      (ext:exit 1))))"  || exit 1
	    shift
	done 
	;;
    remove)
	echo $0 Removing packages...
	shift
	while [ ! -z "$1" ] ; do
	    echo ...removing package $1
	    rm -rf "${clc_lib_dir}/$1"
	    shift
	done
	rmdir $clc_lib_dir 2> /dev/null 
	;;
    install-clc)
	echo Installing clc...
	if [ ! -f $clean_mem ]; then
	    cp $old_mem $clean_mem
	fi
	if [ -x $clisp_dir/$lisp_builder ]; then
	    $builder -norc -q -M $clean_mem \
		-x "
(handler-case
  (progn 
    (when (find-package :c-l-c) ; have to remove 
      (delete-package :c-l-c))  ; for clisp workaround
    (load \"$clisp_dir/install-clc.lisp\") 
    (saveinitmem \"${new_mem}\")
    (ext:exit 0))
  (error (e)
    (ignore-errors (format t \"~&install-clc error: ~A~%\" e))
    (finish-output)
    (ext:exit 1)))"   || lisp_error
  	    mv $new_mem $old_mem || mem_error
	fi
	;;
    remove-clc)
	if [ -f $clean_mem ]; then
	    cp $clean_mem $old_mem
	else
	    echo "Warning: Can't find original image file $clean_mem. Aborting." >& 2
	fi
	;;
    make-user-image)
	if [ ! -f $2 ] ; then 
	    echo "Trying to make-user image, but can not find file $2" >&2
	    exit 1
	fi 
	$builder -norc -q -M $old_mem \
	    -x "(progn    
  (load \"$2\") 
  (saveinitmem \"${new_mem}\"))
  (ext:exit 0)" || lisp_error
	mv $new_mem $old_mem || mem_error
	;;
    *)
	echo "`basename $0`: Unknown command $1" >&2
	echo "Known commands are:" >&2 
	echo "install-clc, remove-clc, rebuild, remove, and make-user-image" >&2
	exit 1
	;;
esac

exit 0
