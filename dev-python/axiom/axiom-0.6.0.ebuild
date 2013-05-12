# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/axiom/axiom-0.6.0.ebuild,v 1.14 2013/05/12 18:32:59 floppym Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.* *-jython"
PYTHON_USE_WITH="sqlite"

# setup.py uses epsilon.setuphelper.autosetup(), which tries to use
# build-${PYTHON_ABI} directories as packages.
DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

inherit eutils twisted

MY_PN="Axiom"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Axiom is an object database implemented on top of SQLite."
HOMEPAGE="http://divmod.org/trac/wiki/DivmodAxiom http://pypi.python.org/pypi/Axiom"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=dev-python/epsilon-0.6
	>=dev-python/twisted-2.4
	>=dev-python/twisted-conch-0.7.0-r1"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

DOCS="NAME.txt"
PYTHON_MODNAME="axiom twisted/plugins/axiom_plugins.py"
TWISTED_PLUGINS="axiom.plugins twisted.plugins"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.5.30-sqlite3.patch"
	epatch "${FILESDIR}/${PN}-0.5.30-sqlite3_3.6.4.patch"
	python_copy_sources
}

src_compile() {
	# Skip distutils_src_compile to avoid installation of $(python_get_sitedir)/build directory.
	:
}

src_test() {
	python_execute_trial -P . axiom
}

src_install() {
	PORTAGE_PLUGINCACHE_NOOP="1" distutils_src_install
}
