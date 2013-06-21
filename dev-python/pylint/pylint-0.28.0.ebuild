# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylint/pylint-0.28.0.ebuild,v 1.1 2013/06/21 15:39:51 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python2_{6,7} python{3_1,3_2,3_3} )
#PYTHON_REQ_USE="tk"
inherit distutils-r1

DESCRIPTION="Python code static checker"
HOMEPAGE="http://www.logilab.org/project/pylint http://pypi.python.org/pypi/pylint"
SRC_URI="ftp://ftp.logilab.org/pub/${PN}/${P}.tar.gz mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="examples"

# Versions specified in __pkginfo__.py.
RDEPEND=">=dev-python/logilab-common-0.19.0[$(python_gen_usedep python{2_6,2_7,3_2})]
	>=dev-python/astng-0.16.1[$(python_gen_usedep python{2_6,2_7,3_2})]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

DOCS=( doc/FAQ.txt doc/features.txt doc/manual.txt doc/quickstart.txt )
DISTUTILS_IN_SOURCE_BUILD=1

PATCHES=( "${FILESDIR}"/${PN}-0.26.0-gtktest.patch )

python_test() {
	# Test suite broken with Python 3
	local msg="Test suite broken with ${EPYTHON}"
	if [[ "${EPYTHON}" == python3* ]]; then
                einfo "${msg}"
        else
		# https://bitbucket.org/logilab/pylint/issue/11/apparent-regression-in-testsuite-pylint
		# This 'issue' became' declared fixed by accident for version 0.27.0 despite being made citing 0.28.0
		pytest || die "Tests failed under ${EPYTHON}"
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
