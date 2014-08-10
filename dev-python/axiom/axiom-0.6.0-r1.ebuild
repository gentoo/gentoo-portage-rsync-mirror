# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/axiom/axiom-0.6.0-r1.ebuild,v 1.3 2014/08/10 21:07:14 slyfox Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="sqlite"

inherit twisted-r1

DESCRIPTION="Object database implemented on top of SQLite"
HOMEPAGE="http://divmod.org/trac/wiki/DivmodAxiom http://pypi.python.org/pypi/Axiom"
SRC_URI="mirror://pypi/${TWISTED_PN:0:1}/${TWISTED_PN}/${TWISTED_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-python/epsilon-0.6.0-r2[${PYTHON_USEDEP}]
	dev-python/twisted-core[${PYTHON_USEDEP}]
	dev-python/twisted-conch[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-0.5.30-sqlite3.patch"
	"${FILESDIR}/${PN}-0.5.30-sqlite3_3.6.4.patch"
)

TWISTED_PLUGINS+=( axiom.plugins )

python_install() {
	distutils-r1_python_install

	touch "${D}$(python_get_sitedir)"/axiom/plugins/dropin.cache || die
}

python_install_all() {
	dodoc NAME.txt

	distutils-r1_python_install_all
}
