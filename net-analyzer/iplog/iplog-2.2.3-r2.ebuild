# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iplog/iplog-2.2.3-r2.ebuild,v 1.14 2012/07/24 00:14:17 blueness Exp $

inherit eutils

DESCRIPTION="iplog is a TCP/IP traffic logger"
HOMEPAGE="http://ojnk.sourceforge.net/"
SRC_URI="mirror://sourceforge/ojnk/${P}.tar.gz"

LICENSE="|| ( GPL-2 FDL-1.1 )"
SLOT="0"
KEYWORDS="alpha ~mips ppc sparc x86 ~amd64"
IUSE=""

DEPEND="net-libs/libpcap"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-DLT_LINUX_SSL.patch
}

src_compile() {
	econf || die
	make CFLAGS="${CFLAGS} -D_REENTRANT" all || die
}

src_install() {
	make \
		prefix="${D}"/usr \
		mandir="${D}"/usr/share/man \
		install || die
	dodoc AUTHORS NEWS README TODO example-iplog.conf

	newinitd "${FILESDIR}"/iplog.rc6 iplog
}
