# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/epsilon/epsilon-0.6.0.ebuild,v 1.15 2013/08/03 09:45:36 mgorny Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.* *-jython"
DISTUTILS_SRC_TEST="trial"
DISTUTILS_DISABLE_TEST_DEPENDENCY="1"

# setup.py uses epsilon.setuphelper.autosetup(), which tries to use
# build-${PYTHON_ABI} directories as packages.
DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

inherit eutils twisted

MY_PN="Epsilon"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Epsilon is a Python utilities package, most famous for its Time class."
HOMEPAGE="http://divmod.org/trac/wiki/DivmodEpsilon http://pypi.python.org/pypi/Epsilon"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=dev-python/twisted-core-2.4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

DOCS="NAME.txt NEWS.txt"

src_prepare() {
	# Rename to avoid file-collisions
	mv bin/benchmark bin/epsilon-benchmark
	sed -i \
		-e "s#bin/benchmark#bin/epsilon-benchmark#" \
		setup.py || die "sed failed"
	# otherwise we get sandbox violations as it wants to update
	# the plugin cache
	epatch "${FILESDIR}/epsilon_plugincache_portagesandbox.patch"

	python_copy_sources
}

src_compile() {
	# Skip distutils_src_compile to avoid installation of $(python_get_sitedir)/build directory.
	:
}

src_test() {
	# Release tests need DivmodCombinator.
	rm -f epsilon/test/test_release.py*

	distutils_src_test
}
