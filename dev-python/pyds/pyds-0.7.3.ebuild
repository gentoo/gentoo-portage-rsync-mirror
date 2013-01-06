# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyds/pyds-0.7.3.ebuild,v 1.5 2012/09/09 15:09:07 armin76 Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils eutils

MY_P="PyDS-${PV}"

DESCRIPTION="Python Desktop Server"
HOMEPAGE="http://pyds.muensterland.org/"
SRC_URI="http://simon.bofh.ms/~gb/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="app-text/silvercity
	>=dev-db/metakit-2.4.9.2[python]
	>=dev-python/cheetah-0.9.15
	>=dev-python/docutils-0.3
	>=dev-python/imaging-1.1.3
	>=dev-python/medusa-0.5.4
	>=dev-python/pyrex-0.5
	>=dev-python/soappy-0.11.1
	virtual/jpeg
	sys-libs/zlib"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

DOCS="OVERVIEW"
PYTHON_MODNAME="PyDS"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${PN}-0.6.5-py2.3.patch"
}
