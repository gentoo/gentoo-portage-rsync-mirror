# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/beautifulsoup/beautifulsoup-4.1.3-r1.ebuild,v 1.2 2013/01/17 22:42:33 chutzpah Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} )

inherit distutils-r1

MY_PN="${PN}4"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Provides pythonic idioms for iterating, searching, and modifying an HTML/XML parse tree"
HOMEPAGE="http://www.crummy.com/software/BeautifulSoup/
	http://pypi.python.org/pypi/beautifulsoup4"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="4"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="doc test"

DEPEND="doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
		test? ( dev-python/nose[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}] )"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

REQUIRED_USE="doc? ( !python_targets_python3_3 )"

python_compile_all() {
	if use doc; then
		emake -C doc html
	fi
}

python_test() {
	nosetests -w "${BUILD_DIR}"/lib || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=doc/build/html/.
	distutils-r1_python_install_all
}
