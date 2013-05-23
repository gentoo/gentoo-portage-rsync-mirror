# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/evemu/evemu-1.1.0.ebuild,v 1.1 2013/05/23 22:47:19 radhermit Exp $

EAPI=5
PYTHON_COMPAT=( python2_{6,7} )
AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1

inherit autotools-utils python-single-r1

DESCRIPTION="Tools and bindings for kernel input event device emulation, data capture, and replay"
HOMEPAGE="http://www.freedesktop.org/wiki/Evemu/"
SRC_URI="http://www.freedesktop.org/software/${PN}/${P}.tar.xz"

LICENSE="LGPL-3 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python static-libs"

RDEPEND="python? ( ${PYTHON_DEPS} )"
DEPEND="app-arch/xz-utils
	${RDEPEND}"

src_prepare() {
	if ! use python ; then
		sed '/SUBDIRS/s/python//' -i Makefile.am || die
		autotools-utils_src_prepare
	fi
}

src_test() {
	if use python ; then
		if [[ ! ${EUID} -eq 0 ]] || has sandbox $FEATURES || has usersandbox $FEATURES ; then
			ewarn "Tests require userpriv, sandbox, and usersandbox to be disabled in FEATURES."
		else
			emake check
		fi
	fi
}
