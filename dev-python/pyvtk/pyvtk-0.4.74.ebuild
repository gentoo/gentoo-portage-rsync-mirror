# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyvtk/pyvtk-0.4.74.ebuild,v 1.2 2010/05/26 16:59:26 arfrever Exp $

EAPI="2"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

MY_P=PyVTK-${PV}

DESCRIPTION="Tools for manipulating VTK files in Python"
HOMEPAGE="http://cens.ioc.ee/projects/pyvtk/"
SRC_URI="http://cens.ioc.ee/projects/pyvtk/rel-0.x/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

S="${WORKDIR}"/${MY_P}

RESTRICT_PYTHON_ABIS="3.*"

src_prepare() {
	epatch "${FILESDIR}"/${P}.patch
	distutils_src_prepare
}
