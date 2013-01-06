# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cx_Freeze/cx_Freeze-4.3.1.ebuild,v 1.2 2012/12/27 07:25:09 pinkbyte Exp $

EAPI="5"

SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="*"

inherit distutils

DESCRIPTION="Create standalone executables from Python scripts"
HOMEPAGE="http://cx-freeze.sourceforge.net"
SRC_URI="mirror://sourceforge/cx-freeze/${P}.tar.gz"

LICENSE="PYTHON"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DOCS=( README.txt )

src_prepare() {
	# do not strip binaries
	sed -i -e '/extraArgs.append("-s")/d' setup.py || die 'sed on setup.py failed'

	distutils_src_prepare
}
