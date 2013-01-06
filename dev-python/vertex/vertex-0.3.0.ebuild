# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/vertex/vertex-0.3.0.ebuild,v 1.7 2012/10/17 09:16:30 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.* *-jython"
DISTUTILS_SRC_TEST="trial"
DISTUTILS_DISABLE_TEST_DEPENDENCY="1"

# setup.py uses epsilon.setuphelper.autosetup(), which tries to use
# build-${PYTHON_ABI} directories as packages.
DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

inherit distutils

MY_PN="Vertex"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="An implementation of the Q2Q protocol"
HOMEPAGE="http://divmod.org/trac/wiki/DivmodVertex http://pypi.python.org/pypi/Vertex"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/openssl-0.9.7
	>=dev-python/epsilon-0.5.0
	>=dev-python/pyopenssl-0.6
	>=dev-python/twisted-2.4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

DOCS="NAME.txt README.txt"

src_compile() {
	# Skip distutils_src_compile to avoid installation of $(python_get_sitedir)/build directory.
	:
}
