# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/amara/amara-2.0.0_alpha6-r1.ebuild,v 1.2 2013/01/19 13:11:56 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7} )
PYTHON_REQ_USE='wide-unicode(+)'

inherit distutils-r1

MY_PN="Amara"
MY_P="${MY_PN}-${PV/_alpha/a}"

DESCRIPTION="Library for XML processing in Python"
HOMEPAGE="http://wiki.xml3k.org/Amara2"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples test"

RDEPEND=">=dev-libs/expat-2.1.0-r2[unicode]
	dev-python/html5lib[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}/${PV}-unbundle-expat.patch"
	"${FILESDIR}/${PV}-unbundle-python-libs.patch"
)

python_test() {
	nosetests -w test --exe \
		|| die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r demo
		docompress -x "${INSDESTTREE}"/demo
	fi
}
