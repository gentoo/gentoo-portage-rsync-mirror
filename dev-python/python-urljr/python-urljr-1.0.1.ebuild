# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-urljr/python-urljr-1.0.1.ebuild,v 1.4 2010/07/08 16:08:43 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

DESCRIPTION="JanRain's URL Utilities"
HOMEPAGE="http://www.openidenabled.com/openid/libraries/python/"
SRC_URI="http://www.openidenabled.com/resources/downloads/python-openid/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="curl test"

RDEPEND="curl? ( >=dev-python/pycurl-7.15.1 )"
DEPEND="${RDEPEND}
	test? ( >=dev-python/pycurl-7.15.1 )"

PYTHON_MODNAME="urljr"

src_prepare() {
	distutils_src_prepare

	# Test fails if it finds 'localhost' instead of '127.0.0.1'.
	epatch "${FILESDIR}/${P}-gentoo-test_fetchers.patch"
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" admin/runtests
	}
	python_execute_function testing
}
