# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/zoinks/zoinks-0.4.1.ebuild,v 1.7 2009/07/23 22:42:10 vostorga Exp $

inherit eutils

DESCRIPTION="programmer's text editor and development environment"
HOMEPAGE="http://zoinks.mikelockwood.com"
SRC_URI="http://${PN}.mikelockwood.com/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="nls"

RDEPEND="x11-libs/libX11
	x11-libs/libXpm
	x11-libs/libXext
	x11-libs/libXt"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	sed -i -e 's:-g -Werror::g' "${S}"/configure*
}

src_compile() {
	econf $(use_enable nls)	--disable-imlib
	emake CXX=$(tc-getCXX) || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
	doicon ide/Pixmaps/${PN}.xpm
	make_desktop_entry ${PN} "Zoinks!" ${PN} "Utility;TextEditor"
}
