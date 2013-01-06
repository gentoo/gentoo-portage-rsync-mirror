# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/yersinia/yersinia-0.7.1.ebuild,v 1.4 2009/05/29 01:20:58 beandog Exp $

inherit eutils

DESCRIPTION="A layer 2 attack framework"
HOMEPAGE="http://www.yersinia.net/"
SRC_URI="http://www.yersinia.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gtk ncurses"

DEPEND="ncurses? ( >=sys-libs/ncurses-5.5 )
	gtk? ( =x11-libs/gtk+-2* )
	>=net-libs/libnet-1.1.2
	>=net-libs/libpcap-0.9.4"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-no-ncurses.patch"
	sed -e "s:^\(CFLAGS = \).*:\1${CFLAGS}:" -i src/Makefile.in
}

src_compile() {
	econf \
		--enable-admin \
		--with-pcap-includes=/usr/include \
		$(use_with ncurses) \
		$(use_enable gtk)
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog FAQ README THANKS TODO || die
}
