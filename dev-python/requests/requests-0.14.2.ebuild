# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/requests/requests-0.14.2.ebuild,v 1.1 2012/10/30 09:37:14 patrick Exp $

EAPI="4"
PYTHON_DEPEND="*:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils eutils

DESCRIPTION="HTTP library for human beings"
HOMEPAGE="http://python-requests.org/ http://pypi.python.org/pypi/requests"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND="app-misc/ca-certificates
	dev-python/chardet
	dev-python/oauthlib
	dev-python/urllib3"
DEPEND="${RDEPEND}
	dev-python/setuptools"

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES=1

# tests connect to various remote sites
RESTRICT="test"

src_prepare() {
	# use system libs for chardet, oauthlib, and urllib3
	rm -r requests/packages || die
	epatch "${FILESDIR}"/${PN}-0.14.1-system-libs.patch

	# use system ca-certificates
	rm requests/cacert.pem || die
	epatch "${FILESDIR}"/${PN}-0.14.1-system-cacerts.patch

	# Different packages are installed depending on the python version.
	# Need to remove stale egg-info data and build in separate directories.
	rm -r requests.egg-info || die

	distutils_src_prepare
}

src_test() {
	echoit() { echo "$@"; "$@"; }
	testing() {
		echoit nosetests --verbosity=1 tests/*.py
	}
	python_execute_function testing
}
