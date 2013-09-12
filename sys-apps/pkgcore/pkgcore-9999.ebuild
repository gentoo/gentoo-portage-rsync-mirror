# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pkgcore/pkgcore-9999.ebuild,v 1.12 2013/09/12 22:37:09 mgorny Exp $

EAPI="3"
DISTUTILS_SRC_TEST="setup.py"

EGIT_REPO_URI="https://code.google.com/p/pkgcore/"
inherit distutils git-2

DESCRIPTION="pkgcore package manager"
HOMEPAGE="http://pkgcore.googlecode.com/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+doc"

RDEPEND=">=dev-lang/python-2.5
	=dev-python/snakeoil-9999
	|| ( >=dev-lang/python-2.5 dev-python/pycrypto )"
DEPEND="${RDEPEND}
	dev-python/sphinx
	dev-python/pyparsing"

DOCS="AUTHORS NEWS"

pkg_setup() {
	# disable snakeoil 2to3 caching...
	unset PY2TO3_CACHEDIR
	python_pkg_setup
}

src_compile() {
	local x
	distutils_src_compile $(use_enable doc html-docs)
	# Find the first set of generated manpages, and symlink
	# those into the source root.
	for x in ${PYTHON_ABIS}; do
		ln -s "${S}/build-${x}/sphinx/man" "${S}/man"
		break
	done
}

src_install() {
	distutils_src_install $(use_enable doc html-docs)
}

pkg_postinst() {
	distutils_pkg_postinst
	pplugincache
}
