# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycmd/pycmd-1.0.ebuild,v 1.1 2010/12/13 13:33:35 arfrever Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="pycmd: tools for managing/searching Python related files."
HOMEPAGE="http://pypi.python.org/pypi/pycmd"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND=">=dev-python/py-1.4.0"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools"

DOCS="CHANGELOG README.txt"
