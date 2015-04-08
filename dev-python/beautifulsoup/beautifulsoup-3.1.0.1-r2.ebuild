# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/beautifulsoup/beautifulsoup-3.1.0.1-r2.ebuild,v 1.17 2014/12/22 02:36:54 idella4 Exp $

EAPI="5"
# A few tests fail with python3.3/3.4 :(
PYTHON_COMPAT=( python{3_3,3_4} pypy3 )

inherit distutils-r1 eutils

MY_PN="BeautifulSoup"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="HTML/XML parser for quick-turnaround applications like screen-scraping"
HOMEPAGE="http://www.crummy.com/software/BeautifulSoup/ http://pypi.python.org/pypi/BeautifulSoup"
SRC_URI="http://www.crummy.com/software/${MY_PN}/download/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="python-3"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND="!dev-python/beautifulsoup:0"

S="${WORKDIR}/${MY_P}"
PATCHES=( "${FILESDIR}/${P}-python-3.patch" )

python_test() {
	"${PYTHON}" BeautifulSoupTests.py || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	# Delete useless files.
	rm -r "${ED%/}/usr/bin" || die
}
