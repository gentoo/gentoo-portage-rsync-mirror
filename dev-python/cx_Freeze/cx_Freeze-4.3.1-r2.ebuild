# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cx_Freeze/cx_Freeze-4.3.1-r2.ebuild,v 1.2 2013/11/18 13:43:42 pinkbyte Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )
inherit distutils-r1

DESCRIPTION="Create standalone executables from Python scripts"
HOMEPAGE="http://cx-freeze.sourceforge.net"
SRC_URI="mirror://sourceforge/cx-freeze/${P}.tar.gz"

LICENSE="PYTHON"
SLOT="0"
KEYWORDS="amd64 x86"

DOCS=( README.txt )

python_prepare() {
	# do not strip binaries, respect LDFLAGS
	sed -i -e '/extraArgs.append("-s")/s/extraArgs.append("-s")/extraArgs.extend(vars["LDFLAGS"].split())/' setup.py || die 'sed on setup.py failed'
}
