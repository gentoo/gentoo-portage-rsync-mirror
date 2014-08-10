# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/amara/amara-2.0.0.ebuild,v 1.1 2014/08/10 12:18:56 dev-zero Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE='wide-unicode(+)'

inherit distutils-r1

MY_PN="Amara"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Library for XML processing in Python"
HOMEPAGE="http://wiki.xml3k.org/Amara2"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples test"

RDEPEND="dev-python/html5lib[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}/2.0.0_alpha6-unbundle-python-libs.patch"
)

# Maintainter notes:
# * Bundles expat-2.0.0 but since it is patched we can not simply unbundle it.
#   Unbundling expat leads to a segfault, see bug #452962
# * Many tests still fail. Documentation suggests that they came from 4suite/amara-1.x
#   and are not fully adapted to amara-2.x. Therefore disabling them.

RESTRICT="test"

python_test() {
	nosetests -w test -P --exe -v || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r demo
		docompress -x "${INSDESTTREE}"/demo
	fi
}
