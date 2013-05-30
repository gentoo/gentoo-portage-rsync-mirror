# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/xdsstat-bin/xdsstat-bin-100513.ebuild,v 1.1 2013/05/30 09:32:50 jlec Exp $

MY_PN="${PN/-bin}"

DESCRIPTION="Prints various statistics (that are not available from XDS itself)"
HOMEPAGE="http://strucbio.biologie.uni-konstanz.de/xdswiki/index.php/XDSSTAT"
SRC_URI="ftp://turn5.biologie.uni-konstanz.de/pub/${MY_PN}.bz2"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	sci-chemistry/xds-bin
	amd64? ( app-emulation/emul-linux-x86-baselibs )"
DEPEND=""

RESTRICT="mirror"

QA_PREBUILT="opt/bin/*"

src_install() {
	exeinto /opt/bin
	doexe ${MY_PN}
}
