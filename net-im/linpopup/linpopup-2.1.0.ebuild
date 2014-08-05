# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/linpopup/linpopup-2.1.0.ebuild,v 1.3 2014/08/05 18:34:08 mrueg Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="GTK+ port of the LinPopUp messaging client for Samba (including Samba 3)"
HOMEPAGE="http://linpopup2.sourceforge.net/"
SRC_URI="mirror://sourceforge/linpopup2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXmu
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	x11-proto/xproto"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-link.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README THANKS TODO
	dosym linpopup /usr/bin/LinPopUp || die "dosym failed"
	newicon pixmaps/icon_256.xpm ${PN}.xpm
	make_desktop_entry ${PN} LinPopUp ${PN}
}

pkg_postinst() {
	echo
	elog "To be able to receive messages that are sent to you, you will need to"
	elog "edit your /etc/samba/smb.conf file."
	elog
	elog "Add this line to the [global settings] section:"
	elog
	elog "   message command = /usr/bin/linpopup \"%f\" \"%m\" %s; rm %s"
	elog
	elog "PLEASE NOTE that \"%f\" is not the same thing as %f , '%f' or %f"
	elog "and take care to enter \"%f\" \"%m\" %s exactly as shown above."
	elog
	elog "For more information, please refer to the documentation, found in"
	elog "/usr/share/doc/${P}/"
	echo
}
