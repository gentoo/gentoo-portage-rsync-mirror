# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/linksys-tftp/linksys-tftp-1.2.1.ebuild,v 1.5 2010/10/04 15:57:22 xmw Exp $

IUSE=""
DESCRIPTION="TFTP client suitable for uploading to the Linksys WRT54G Wireless Router"
HOMEPAGE="http://redsand.net/projects/linksys-tftp/linksys-tftp.php"
SRC_URI="mirror://gentoo/linksys-tftp-${PV}.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
DEPEND="sys-devel/gcc"
RDEPEND=""

src_compile() {
	emake || die
}

src_install() {
	exeinto /usr/bin/
	doexe linksys-tftp || die
	dodoc README
}
