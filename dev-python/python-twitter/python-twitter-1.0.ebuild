# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-twitter/python-twitter-1.0.ebuild,v 1.2 2013/09/05 18:47:04 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="This library provides a pure python interface for the Twitter API"
HOMEPAGE="http://code.google.com/p/python-twitter/"
SRC_URI="http://python-twitter.googlecode.com/files/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x64-macos"
IUSE="examples test"

RDEPEND="dev-python/oauth2
	dev-python/simplejson"
DEPEND="${RDEPEND}
	dev-python/setuptools"

DOCS="CHANGES README.md"
PYTHON_MODNAME="twitter.py"

src_prepare() {
	distutils_src_prepare
	# Delete internal copy of simplejson.
	rm -fr simplejson
}

python_test() {
	esetup.py test
}

python_install_all() {
	distutils_src_install

	dohtml doc/twitter.html

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
	fi
}
