# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pkgcore/pkgcore-0.8.6.ebuild,v 1.3 2013/09/12 22:37:09 mgorny Exp $

EAPI="3"
DISTUTILS_SRC_TEST="setup.py"
inherit distutils eutils

DESCRIPTION="pkgcore package manager"
HOMEPAGE="http://pkgcore.googlecode.com/"
SRC_URI="http://pkgcore.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="-doc build"

RDEPEND=">=dev-lang/python-2.5
	>=dev-python/snakeoil-0.5.2
	|| ( >=dev-lang/python-2.5 dev-python/pycrypto )"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx dev-python/pyparsing )"

DOCS="AUTHORS NEWS"

pkg_setup() {
	# disable snakeoil 2to3 caching...
	unset PY2TO3_CACHEDIR
	python_pkg_setup
}

src_compile() {
	distutils_src_compile $(use_enable doc html-docs)
}

src_install() {
	distutils_src_install $(use_enable doc html-docs)
}

pkg_postinst() {
	distutils_pkg_postinst
	pplugincache
}
