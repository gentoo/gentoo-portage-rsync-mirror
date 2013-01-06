# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mantissa/mantissa-0.7.0.ebuild,v 1.7 2012/10/17 09:34:54 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.* *-jython"
DISTUTILS_SRC_TEST="trial xmantissa"
DISTUTILS_DISABLE_TEST_DEPENDENCY="1"

# setup.py uses epsilon.setuphelper.autosetup(), which tries to use
# build-${PYTHON_ABI} directories as packages.
DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

inherit twisted

MY_PN="Mantissa"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="An extensible, multi-protocol, multi-user, interactive application server"
HOMEPAGE="http://divmod.org/trac/wiki/DivmodMantissa http://pypi.python.org/pypi/Mantissa"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/axiom-0.5.7
	>=dev-python/cssutils-0.9.5.1
	>=dev-python/imaging-1.1.6
	>=dev-python/nevow-0.9.5
	>=dev-python/pytz-2005m
	>=dev-python/twisted-8.0.1
	dev-python/twisted-mail
	>=dev-python/vertex-0.2.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

DOCS="NAME.txt NEWS.txt"
PYTHON_MODNAME="axiom/plugins nevow/plugins/mantissa_package.py xmantissa"
TWISTED_PLUGINS="axiom.plugins nevow.plugins xmantissa.plugins"

src_compile() {
	# Skip distutils_src_compile to avoid installation of $(python_get_sitedir)/build directory.
	:
}

src_test() {
	TWISTED_DISABLE_WRITING_OF_PLUGIN_CACHE="1" distutils_src_test
}

src_install() {
	PORTAGE_PLUGINCACHE_NOOP="1" distutils_src_install
}
