# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/astng/astng-0.24.2.ebuild,v 1.1 2013/03/14 16:34:13 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2} pypy{1_9,2_0} )

inherit distutils-r1

DESCRIPTION="Abstract Syntax Tree for logilab packages"
HOMEPAGE="http://www.logilab.org/project/logilab-astng http://pypi.python.org/pypi/logilab-astng"
SRC_URI="ftp://ftp.logilab.org/pub/astng/logilab-${P}.tar.gz mirror://pypi/l/logilab-astng/logilab-${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x64-macos ~x86-macos"
IUSE="test"

# Version specified in __pkginfo__.py.
RDEPEND=">=dev-python/logilab-common-0.53.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( >=dev-python/egenix-mx-base-3.0.0[$(python_gen_usedep python2*)] )"

S="${WORKDIR}/logilab-${P}"

python_test() {
	# Make sure that the tests use correct modules & paths, for now at least
	# python3 currently doesn't pass all tests on std testing

	cd "${BUILD_DIR}"/lib || die
	[[ "${EPYTHON:6:1}" == '3' ]] && return
	pushd logilab/astng > /dev/null || return 1
	pytest $(find . -name test) || die "Tests fail with ${EPYTHON}"
	popd > /dev/null || return 1
}

python_install() {
	distutils-r1_python_install

	rm "${D}$(python_get_sitedir)/logilab/__init__.py" || die
}
