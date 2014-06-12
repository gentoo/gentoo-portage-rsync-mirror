# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/testtools/testtools-0.9.35-r1.ebuild,v 1.1 2014/06/12 08:10:28 patrick Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1 versionator

#SERIES="$(get_version_component_range 1-2)"
SERIES="trunk"

DESCRIPTION="Extensions to the Python unittest library"
HOMEPAGE="https://launchpad.net/testtools http://pypi.python.org/pypi/testtools"
SRC_URI="http://launchpad.net/${PN}/${SERIES}/${PV}/+download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="test"
DISTUTILS_IN_SOURCE_BUILD=1

RDEPEND="dev-python/mimeparse[${PYTHON_USEDEP}]
		dev-python/extras[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( $(python_gen_cond_dep 'dev-python/twisted-core[${PYTHON_USEDEP}]' python2_7) )"

python_test() {
	# https://bugs.launchpad.net/testtools/+bug/1191725
	# https://bugs.launchpad.net/testtools/+bug/1191725
	# These tests pass run from the source, a gentooism
	if ! python_is_python3; then
		sed -e s':test_deferredruntest:#&:g' \
		-e s':test_spinner:#&:g' \
		-i ${PN}/tests/__init__.py || die
	fi
	# Bug 509510 re python-2.7.6
	esetup.py test
}
