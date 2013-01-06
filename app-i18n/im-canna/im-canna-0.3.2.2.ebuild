# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/im-canna/im-canna-0.3.2.2.ebuild,v 1.8 2012/10/27 12:40:32 ago Exp $

EAPI=4

DESCRIPTION="Japanese Canna input method module for GTK+2"
HOMEPAGE="http://bonobo.gnome.gr.jp/~nakai/immodule/"
SRC_URI="http://bonobo.gnome.gr.jp/~nakai/immodule/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.4:2
	app-i18n/canna"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog NEWS README )

pkg_postinst() {
	gtk-query-immodules-2.0 > "${ROOT}/etc/gtk-2.0/gtk.immodules"
}

pkg_postrm() {
	gtk-query-immodules-2.0 > "${ROOT}/etc/gtk-2.0/gtk.immodules"
}
