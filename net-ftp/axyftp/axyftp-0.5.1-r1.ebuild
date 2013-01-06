# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/axyftp/axyftp-0.5.1-r1.ebuild,v 1.3 2012/10/24 19:21:00 ulm Exp $

EAPI=1

inherit eutils

DESCRIPTION="GUI FTP client for X Window System (former WXftp)"
HOMEPAGE="http://www.wxftp.seul.org"
SRC_URI="http://www.wxftp.seul.org/download/${P}.tar.gz"

LICENSE="Artistic LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=x11-libs/motif-2.3:0
	x11-libs/libXt
	x11-libs/libX11
	x11-libs/libXpm
	x11-libs/libXaw"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-built-in-function-exit.patch
}

src_compile(){
	econf --with-help=/usr/share/doc/${PF}/html \
		--with-gui=motif
	emake -j1 || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc CHANGES README TODO
	newicon icons/${PN}-ball64.xpm ${PN}.xpm
	make_desktop_entry ${PN} "AxY FTP" ${PN} "Network;FileTransfer;Motif"
}
