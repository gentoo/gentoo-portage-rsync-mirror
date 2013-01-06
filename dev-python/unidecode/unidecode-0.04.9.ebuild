# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/unidecode/unidecode-0.04.9.ebuild,v 1.4 2012/05/30 12:53:56 xarthisius Exp $

EAPI=4

PYTHON_DEPEND="*:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5"
DISTUTILS_SRC_TEST=setup.py

MY_PN=Unidecode
MY_P=${MY_PN}-${PV}

inherit distutils

DESCRIPTION="Module providing ASCII transliterations of Unicode text"
HOMEPAGE="http://pypi.python.org/pypi/Unidecode"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${MY_P}
