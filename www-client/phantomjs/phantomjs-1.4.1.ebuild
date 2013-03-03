# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/phantomjs/phantomjs-1.4.1.ebuild,v 1.3 2013/03/02 23:40:56 hwoarang Exp $

EAPI="2"

PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils qt4-r2

DESCRIPTION="headless WebKit with JavaScript API"
HOMEPAGE="http://www.phantomjs.org/"
SRC_URI="http://phantomjs.googlecode.com/files/${P}-source.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples python"

RDEPEND="dev-qt/qtwebkit:4
	python? ( dev-python/PyQt4 )"
DEPEND="${RDEPEND}"

# Call all the parent eclasses without having to worry
# about what funcs they actually export.
maybe() { set -- $(declare -F $1); $1; }
multi_eclass() {
	maybe qt4-r2_$1
	if use python ; then
		[[ -d python ]] && cd python
		maybe distutils_$1
	fi
}
pkg_setup()     { multi_eclass ${FUNCNAME} ; }
pkg_preinst()   { multi_eclass ${FUNCNAME} ; }
pkg_postinst()  { multi_eclass ${FUNCNAME} ; }
pkg_prerm()     { multi_eclass ${FUNCNAME} ; }
pkg_postrm()    { multi_eclass ${FUNCNAME} ; }
src_prepare()   { multi_eclass ${FUNCNAME} ; }
src_configure() { multi_eclass ${FUNCNAME} ; }
src_compile()   { multi_eclass ${FUNCNAME} ; }

src_test() {
	./bin/phantomjs test/run-tests.js || die
}

src_install() {
	dobin bin/phantomjs || die
	dodoc ChangeLog README.md

	if use examples ; then
		docinto examples
		dodoc examples/* || die
	fi

	multi_eclass ${FUNCNAME}
}
