# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pytz/pytz-2012h.ebuild,v 1.1 2012/11/03 00:58:24 radhermit Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="World timezone definitions for Python"
HOMEPAGE="http://pypi.python.org/pypi/pytz http://pytz.sourceforge.net/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

DEPEND="dev-python/setuptools
	>=sys-libs/timezone-data-${PV}"
RDEPEND="${DEPEND}"

DOCS="CHANGES.txt"

src_prepare() {
	distutils_src_prepare

	# Use timezone-data zoneinfo.
	epatch "${FILESDIR}/${PN}-2009j-zoneinfo.patch"
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" pytz/tests/test_tzinfo.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	delete_zoneinfo() {
		rm -fr "${ED}$(python_get_sitedir)/pytz/zoneinfo"
	}
	python_execute_function -q delete_zoneinfo
}
