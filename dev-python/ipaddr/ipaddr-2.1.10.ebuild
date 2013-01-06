# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ipaddr/ipaddr-2.1.10.ebuild,v 1.1 2012/03/07 21:32:28 maksbotan Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python IP address manipulation library"
HOMEPAGE="http://code.google.com/p/ipaddr-py/ http://pypi.python.org/pypi/ipaddr"
SRC_URI="http://ipaddr-py.googlecode.com/files/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"
DOCS="README RELEASENOTES"
PYTHON_MODNAME="ipaddr.py"

src_prepare() {
	distutils_src_prepare

	preparation() {
		if [[ "$(python_get_version -l --major)" == "3" ]]; then
			2to3-${PYTHON_ABI} -nw --no-diffs ipaddr.py ipaddr_test.py
		fi
	}
	python_execute_function -s preparation
}

src_test() {
	testing() {
		PYTHONPATH="build/lib" "$(PYTHON)" ipaddr_test.py
	}
	python_execute_function -s testing
}
