# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysvg/pysvg-0.2.1.ebuild,v 1.2 2011/12/29 04:07:51 floppym Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python SVG document creation library"
HOMEPAGE="http://codeboje.de/pysvg/
	http://code.google.com/p/pysvg/
	http://pypi.python.org/pypi/pysvg"
SRC_URI="http://pysvg.googlecode.com/files/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"
