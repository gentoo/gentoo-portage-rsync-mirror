# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/tappy/tappy-0.9.0.ebuild,v 1.1 2013/02/10 22:13:59 hasufell Exp $

EAPI=5

PYTHON_COMPAT=( python2_6 python2_7 )
PYTHON_REQ_USE="xml"
inherit distutils-r1

DESCRIPTION="Tidal Analysis in Python breaks hourly water level into tidal components"
HOMEPAGE="http://tappy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/pywavelets
	sci-libs/scipy[${PYTHON_USEDEP}]"
