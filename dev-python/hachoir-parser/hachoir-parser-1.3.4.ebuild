# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/hachoir-parser/hachoir-parser-1.3.4.ebuild,v 1.1 2010/09/10 22:39:27 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Package of Hachoir parsers used to open binary files"
HOMEPAGE="http://bitbucket.org/haypo/hachoir/wiki/hachoir-parser http://pypi.python.org/pypi/hachoir-parser"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-python/hachoir-core-1.3"
DEPEND="${RDEPEND}
	dev-python/setuptools"

DISTUTILS_GLOBAL_OPTIONS=("--setuptools")
PYTHON_MODNAME="${PN/-/_}"
