# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylint/pylint-0.27.0-r1.ebuild,v 1.7 2013/06/25 03:11:25 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2} )

inherit distutils-r1 eutils

DESCRIPTION="Python code static checker"
HOMEPAGE="http://www.logilab.org/project/pylint http://pypi.python.org/pypi/pylint"
SRC_URI="ftp://ftp.logilab.org/pub/${PN}/${P}.tar.gz mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="examples"

# Versions specified in __pkginfo__.py.
RDEPEND=">=dev-python/logilab-common-0.53.0[${PYTHON_USEDEP}]
	>=dev-python/astng-0.24.3[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"
DOCS=( doc/FAQ.txt doc/features.txt doc/manual.txt doc/quickstart.txt )

python_prepare() {
	epatch "${FILESDIR}"/${PN}-0.26.0-gtktest.patch
}

python_test() {
	local msg="Test suite broken with ${EPYTHON}"
	if [[ "${EPYTHON}" == python3* || "${EPYTHON}" == 'python2.5' ]]; then
		einfo "${msg}"
	else
		pytest || die " Testsuite failed under ${EPYTHON}"
	fi
}

python_install_all() {
	doman man/{pylint,pyreverse}.1 || die "doman failed"

	if use examples; then
		docinto examples
		dodoc examples/* || die "dodoc failed"
	fi
}

pkg_postinst() {
	# Optional dependency on "tk" USE flag would break support for Jython.
	elog "pylint-gui script requires dev-lang/python with \"tk\" USE flag enabled."
}
