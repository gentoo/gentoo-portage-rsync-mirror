# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/skype4py/skype4py-1.0.32.1-r1.ebuild,v 1.3 2013/09/05 18:46:29 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

MY_PN=Skype4Py
MY_P=${MY_PN}-${PV}

DESCRIPTION="Python wrapper for the Skype API"
HOMEPAGE="https://github.com/awahlig/skype4py http://pypi.python.org/pypi/Skype4Py/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="net-im/skype"

S=${WORKDIR}/${MY_P}

PATCHES=( "${FILESDIR}"/${P}-python.patch )
