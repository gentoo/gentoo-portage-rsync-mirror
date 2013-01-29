# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pmw/pmw-2.0.0.ebuild,v 1.2 2013/01/29 12:35:56 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{3_1,3_2,3_3} )
PYTHON_REQ_USE="tk"

inherit distutils-r1

MY_P="Pmw.${PV}"

DESCRIPTION="Toolkit for building high-level compound widgets in Python using the Tkinter module"
HOMEPAGE="http://pmw.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="py3"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="doc examples"

DEPEND="!dev-python/pmw:0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/src"

DOCS="Pmw/README"

pythone_prepare_all() {
	local PATCHES=(
		"${FILESDIR}"/${PN}-1.3.2-install-no-docs.patch
		"${FILESDIR}"/1.3.2-python2.5.patch
		)
	distutils-r1_python_prepare_all
}

python_install_all() {
	local DIR="Pmw/Pmw_1_3_3"

	if use doc; then
		dohtml -a html,gif,py "${DIR}"/doc/*
	fi

	if use examples; then
		insinto "/usr/share/doc/${PF}/examples"
		doins "${DIR}"/demos/*
	fi

	distutils-r1_python_install
}
