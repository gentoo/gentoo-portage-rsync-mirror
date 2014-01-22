# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/axiom/axiom-0.7.0.ebuild,v 1.1 2014/01/22 01:27:25 idella4 Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="sqlite"

inherit twisted-r1

DESCRIPTION="Object database implemented on top of SQLite."
HOMEPAGE="http://divmod.org/trac/wiki/DivmodAxiom http://pypi.python.org/pypi/Axiom"
SRC_URI="mirror://pypi/${TWISTED_PN:0:1}/${TWISTED_PN}/${TWISTED_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="test"

RDEPEND=">=dev-python/epsilon-0.6.0-r2[${PYTHON_USEDEP}]
	dev-python/twisted-core[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-0.13[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}/${PN}-0.5.30-sqlite3_3.6.4.patch" )

TWISTED_PLUGINS+=( axiom.plugins )

python_install() {
	distutils-r1_python_install

	touch "${D}$(python_get_sitedir)"/axiom/plugins/dropin.cache || die
}

python_install_all() {
	dodoc NAME.txt

	distutils-r1_python_install_all
}

python_test() {
	py.test ${PN}/test/ || die "testsuite failed under ${EPYTHON}"
}
