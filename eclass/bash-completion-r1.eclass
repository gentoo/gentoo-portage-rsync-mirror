# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/bash-completion-r1.eclass,v 1.4 2013/06/13 16:23:56 mgorny Exp $

# @ECLASS: bash-completion-r1.eclass
# @MAINTAINER:
# mgorny@gentoo.org
# @BLURB: A few quick functions to install bash-completion files
# @EXAMPLE:
#
# @CODE
# EAPI=4
#
# src_install() {
# 	default
#
# 	newbashcomp contrib/${PN}.bash-completion ${PN}
# }
# @CODE

case ${EAPI:-0} in
	0|1|2|3|4|5) ;;
	*) die "EAPI ${EAPI} unsupported (yet)."
esac

# @FUNCTION: _bash-completion-r1_get_bashcompdir
# @INTERNAL
# @DESCRIPTION:
# Get unprefixed bash-completion directory.
_bash-completion-r1_get_bashcompdir() {
	debug-print-function ${FUNCNAME} "${@}"

	echo /usr/share/bash-completion
}

# @FUNCTION: get_bashcompdir
# @DESCRIPTION:
# Get the bash-completion directory.
get_bashcompdir() {
	debug-print-function ${FUNCNAME} "${@}"

	echo "${EPREFIX}$(_bash-completion-r1_get_bashcompdir)"
}

# @FUNCTION: dobashcomp
# @USAGE: file [...]
# @DESCRIPTION:
# Install bash-completion files passed as args. Has EAPI-dependant failure
# behavior (like doins).
dobashcomp() {
	debug-print-function ${FUNCNAME} "${@}"

	(
		insinto "$(_bash-completion-r1_get_bashcompdir)"
		doins "${@}"
	)
}

# @FUNCTION: newbashcomp
# @USAGE: file newname
# @DESCRIPTION:
# Install bash-completion file under a new name. Has EAPI-dependant failure
# behavior (like newins).
newbashcomp() {
	debug-print-function ${FUNCNAME} "${@}"

	(
		insinto "$(_bash-completion-r1_get_bashcompdir)"
		newins "${@}"
	)
}
