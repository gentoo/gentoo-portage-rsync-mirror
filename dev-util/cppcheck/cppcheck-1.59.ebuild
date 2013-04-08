# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cppcheck/cppcheck-1.59.ebuild,v 1.1 2013/04/08 07:43:40 xmw Exp $

EAPI="3"
PYTHON_DEPEND="htmlreport? 2"

inherit distutils eutils qt4-r2 toolchain-funcs

DESCRIPTION="static analyzer of C/C++ code"
HOMEPAGE="http://apps.sourceforge.net/trac/cppcheck/"
SRC_URI="mirror://sourceforge/cppcheck/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="htmlreport qt4"

DEPEND="htmlreport? ( dev-python/pygments )
	qt4? ( dev-qt/qtgui:4 )"
RDEPEND="${DEPEND}"

DISTUTILS_SETUP_FILES=("htmlreport|setup.py")

pkg_setup() {
	if use htmlreport ; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	if use htmlreport ; then
		pushd htmlreport
		python_convert_shebangs -r 2 .
		distutils_src_prepare
		popd
	fi
}

src_configure() {
	tc-export CXX
	if use qt4 ; then
		pushd gui
		qt4-r2_src_configure
		popd
	fi
}

src_compile() {
	emake || die
	if use qt4 ; then
		pushd gui
		qt4-r2_src_compile
		popd
	fi
	use htmlreport && distutils_src_compile
	#https://sourceforge.net/apps/trac/cppcheck/ticket/4149
	#$(tc-getCXX) ${CFLAGS} ${LDFLAGS} -o ${PN}-democlient.cgi \
	#	democlient.cpp -I../lib democlient.cpp
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc readme.txt || die
	if use qt4 ; then
		dobin gui/${PN}-gui || die
		dodoc readme_gui.txt gui/{projectfile.txt,gui.cppcheck} || die
	fi
	use htmlreport && distutils_src_install
	#dobin ${PN}-democlient.cgi
}

pkg_postinst() {
	use htmlreport && distutils_pkg_postinst
}

pkg_postrm() {
	use htmlreport && distutils_pkg_postrm
}
