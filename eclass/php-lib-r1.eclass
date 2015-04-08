# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/php-lib-r1.eclass,v 1.11 2012/02/12 21:48:58 mabi Exp $

# @ECLASS: php-lib-r1.eclass
# @MAINTAINER:
# Gentoo PHP team <php-bugs@gentoo.org>
# @AUTHOR:
# Author: Stuart Herbert <stuart@gentoo.org>
# Author: Luca Longinotti <chtekk@gentoo.org>
# @BLURB: A unified interface for adding new PHP libraries.
# @DESCRIPTION:
# This eclass provides a unified interface for adding new PHP libraries.
# PHP libraries are PHP scripts designed for reuse inside other PHP scripts.

inherit depend.php

EXPORT_FUNCTIONS src_install

DEPEND="dev-lang/php"
RDEPEND="${DEPEND}"

# @ECLASS-VARIABLE: PHP_LIB_NAME
# @DESCRIPTION:
# Defaults to ${PN} unless set manually in the ebuild.
[[ -z "${PHP_LIB_NAME}" ]] && PHP_LIB_NAME="${PN}"

# @FUNCTION: php-lib-r1_src_install
# @USAGE: <directory to install from> <list of files>
# @DESCRIPTION:
# Takes care of install for PHP libraries.
# You have to pass in a list of the PHP files to install.

# @VARIABLE: DOCS
# @DESCRIPTION:
# Set in ebuild if you wish to install additional, package-specific documentation.

# $1 - directory in ${S} to insert from
# $2 ... list of files to install
php-lib-r1_src_install() {
	local x

	S_DIR="$1"
	shift

	for x in $@ ; do
		SUBDIR="$(dirname ${x})"
		insinto "/usr/share/php/${PHP_LIB_NAME}/${SUBDIR}"
		doins "${S_DIR}/${x}"
	done

	for doc in ${DOCS} ; do
		[[ -s ${doc} ]] && dodoc-php ${doc}
	done
}
