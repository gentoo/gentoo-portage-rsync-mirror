# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/rp-l2tp/rp-l2tp-0.4-r1.ebuild,v 1.1 2007/04/15 10:42:17 mrness Exp $

inherit eutils

DESCRIPTION="RP-L2TP is a user-space implementation of L2TP for Linux and other UNIX systems"
HOMEPAGE="http://sourceforge.net/projects/rp-l2tp/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc x86"
SLOT="0"
IUSE=""

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-gentoo.patch"
}

src_install() {
	make RPM_INSTALL_ROOT="${D}" install || die "make install failed"

	dodoc README
	newdoc l2tp.conf rp-l2tpd.conf
	cp -pPR libevent/Doc "${D}/usr/share/doc/${PF}/libevent"

	newinitd "${FILESDIR}/rp-l2tpd-init" rp-l2tpd
}
