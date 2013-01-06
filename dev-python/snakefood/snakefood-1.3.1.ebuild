# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/snakefood/snakefood-1.3.1.ebuild,v 1.2 2010/07/23 22:41:02 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit distutils

DESCRIPTION="Generate dependency graphs from Python code"
HOMEPAGE="http://furius.ca/snakefood/"
SRC_URI="http://furius.ca/downloads/${PN}/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

DOCS="CHANGES"
