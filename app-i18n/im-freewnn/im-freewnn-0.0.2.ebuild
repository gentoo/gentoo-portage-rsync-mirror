# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/im-freewnn/im-freewnn-0.0.2.ebuild,v 1.9 2012/05/03 19:24:31 jdhore Exp $

EAPI="1"

inherit eutils

DESCRIPTION="Japanese FreeWnn input method module for GTK+2"
HOMEPAGE="http://bonobo.gnome.gr.jp/~nakai/immodule/"
SRC_URI="http://bonobo.gnome.gr.jp/~nakai/immodule/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc ~ppc64 x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.4:2
	app-i18n/freewnn"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-wnnrc-gentoo.diff
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	gtk-query-immodules-2.0 > "${ROOT}/etc/gtk-2.0/gtk.immodules"
}

pkg_postrm() {
	gtk-query-immodules-2.0 > "${ROOT}/etc/gtk-2.0/gtk.immodules"
}
