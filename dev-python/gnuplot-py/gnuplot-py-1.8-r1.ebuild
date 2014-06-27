# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnuplot-py/gnuplot-py-1.8-r1.ebuild,v 1.3 2014/06/27 15:12:20 jer Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )
PYTHON_SINGLE_IMPL=true

inherit distutils-r1 eutils

DESCRIPTION="A python wrapper for Gnuplot"
HOMEPAGE="http://gnuplot-py.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="doc"

DEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}
	sci-visualization/gnuplot"

DOCS=( ANNOUNCE.txt CREDITS.txt FAQ.txt NEWS.txt TODO.txt )

src_prepare() {
	distutils-r1_src_prepare
	epatch "${FILESDIR}"/${PN}-1.7-mousesupport.patch
}

src_install() {
	distutils-r1_src_install

	if use doc; then
		insinto /usr/share/doc/${PF}/html
		doins -r doc/Gnuplot/*
	fi
}
