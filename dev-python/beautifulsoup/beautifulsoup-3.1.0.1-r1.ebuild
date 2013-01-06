# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/beautifulsoup/beautifulsoup-3.1.0.1-r1.ebuild,v 1.16 2012/10/13 18:41:14 armin76 Exp $

EAPI="3"
PYTHON_DEPEND="3"
SUPPORT_PYTHON_ABIS="1"
# Avoid collisions with python-2 slot.
RESTRICT_PYTHON_ABIS="2.* *-jython"

inherit distutils eutils

MY_PN="BeautifulSoup"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="HTML/XML parser for quick-turnaround applications like screen-scraping."
HOMEPAGE="http://www.crummy.com/software/BeautifulSoup/ http://pypi.python.org/pypi/BeautifulSoup"
SRC_URI="http://www.crummy.com/software/${MY_PN}/download/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="python-3"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND="!dev-python/beautifulsoup:0"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="BeautifulSoup.py BeautifulSoupTests.py"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-python-3.patch"
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" BeautifulSoupTests.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	# Delete useless files.
	rm -fr "${ED}usr/bin"
}
