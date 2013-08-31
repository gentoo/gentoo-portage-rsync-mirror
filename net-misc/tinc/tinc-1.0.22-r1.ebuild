# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tinc/tinc-1.0.22-r1.ebuild,v 1.1 2013/08/30 23:58:02 blueness Exp $

EAPI="5"
inherit systemd

DESCRIPTION="tinc is an easy to configure VPN implementation"
HOMEPAGE="http://www.tinc-vpn.org/"
SRC_URI="http://www.tinc-vpn.org/packages/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="+lzo uml vde +zlib"

DEPEND=">=dev-libs/openssl-0.9.7
	lzo? ( dev-libs/lzo:2 )
	zlib? ( >=sys-libs/zlib-1.1.4 )"
RDEPEND="${DEPEND}
	vde? ( net-misc/vde )"

src_configure() {
	econf \
		--enable-jumbograms \
		--disable-tunemu  \
		$(use_enable lzo) \
		$(use_enable uml) \
		$(use_enable vde) \
		$(use_enable zlib)
}

src_install() {
	emake DESTDIR="${D}" install
	dodir /etc/tinc
	dodoc AUTHORS NEWS README THANKS
	doinitd "${FILESDIR}"/tincd
	doinitd "${FILESDIR}"/tincd.lo
	doconfd "${FILESDIR}"/tinc.networks
	newconfd "${FILESDIR}"/tincd.conf tincd
	systemd_newunit "${FILESDIR}"/tincd_at.service "tincd@.service"
}

pkg_postinst() {
	elog "This package requires the tun/tap kernel device."
	elog "Look at http://www.tinc-vpn.org/ for how to configure tinc"
}
