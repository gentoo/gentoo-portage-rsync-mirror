# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pkipplib/pkipplib-0.07.ebuild,v 1.2 2010/12/24 22:28:16 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Pkipplib is a Python module which parses IPP requests"
HOMEPAGE="http://www.pykota.com/software/pkipplib/"
SRC_URI="http://www.pykota.com/software/pkipplib/download/tarballs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""
