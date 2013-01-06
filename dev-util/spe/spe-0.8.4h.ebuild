# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/spe/spe-0.8.4h.ebuild,v 1.6 2012/09/05 07:43:56 jlec Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils eutils

MY_PV="0.8.4.h"

DESCRIPTION="Python IDE with Blender support"
HOMEPAGE="http://pythonide.stani.be/"
SRC_URI="mirror://berlios/python/spe-${MY_PV}-wx2.6.1.0.tar.gz"

IUSE=""
SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~ppc x86"

DEPEND=""
RDEPEND=">=dev-python/pychecker-0.8.18
	>=dev-python/wxpython-2.6
	>=dev-util/wxglade-0.3.2"

S="${WORKDIR}/spe-${MY_PV}"

PYTHON_MODNAME="_spe"

src_install() {
	distutils_src_install

	doicon _spe/images/spe.png

	domenu spe.desktop
}
