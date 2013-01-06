# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mygpoclient/mygpoclient-1.6.ebuild,v 1.1 2012/04/19 08:36:58 patrick Exp $

EAPI=3

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="A gpodder.net client library"
HOMEPAGE="http://thp.io/2010/mygpoclient/"
SRC_URI="http://thp.io/2010/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/simplejson"
DEPEND="${RDEPEND}
	test? (
		dev-python/coverage
		dev-python/minimock
	)"

src_prepare() {
	distutils_src_prepare

	# Disable tests requring network connection.
	rm -f mygpoclient/http_test.py
}

src_test() {
	distutils_src_test --cover-erase --with-coverage --with-doctest --cover-package=mygpoclient
}

src_install() {
	distutils_src_install

	delete_tests() {
		rm -f "${ED}$(python_get_sitedir)/mygpoclient/"*_test.py
	}
	python_execute_function -q delete_tests
}
