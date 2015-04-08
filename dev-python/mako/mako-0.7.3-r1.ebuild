# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mako/mako-0.7.3-r1.ebuild,v 1.12 2014/09/30 09:52:08 jer Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2} )

inherit distutils-r1

MY_P="Mako-${PV}"

DESCRIPTION="A Python templating language"
HOMEPAGE="http://www.makotemplates.org/ http://pypi.python.org/pypi/Mako"
SRC_URI="http://www.makotemplates.org/downloads/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ppc ~ppc64 s390 sh sparc x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="doc test"

RDEPEND=">=dev-python/beaker-1.1[${PYTHON_USEDEP}]
	>=dev-python/markupsafe-0.9.2[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}/test-fix.patch"
)

python_test() {
	cp -r -l test "${BUILD_DIR}"/ || die

	if [[ ${EPYTHON} == python3.* ]]; then
		# Notes:
		#   -W is not supported by python3.1
		#   -n causes Python to write into hardlinked files
		2to3 --no-diffs -w "${BUILD_DIR}"/test || die
	fi

	cd "${BUILD_DIR}"/test || die
	nosetests || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	rm -rf doc/build

	use doc && local HTML_DOCS=( doc/. )
	distutils-r1_python_install_all
}
