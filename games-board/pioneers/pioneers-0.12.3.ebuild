# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pioneers/pioneers-0.12.3.ebuild,v 1.7 2012/05/04 04:30:10 jdhore Exp $

EAPI=2
inherit eutils gnome2

DESCRIPTION="A clone of the popular board game The Settlers of Catan"
HOMEPAGE="http://pio.sourceforge.net/"
SRC_URI="mirror://sourceforge/pio/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="nls"

RDEPEND=">=dev-libs/glib-2.6:2
	>=gnome-base/libgnome-2.10
	>=x11-libs/gtk+-2.6:2
	>=app-text/scrollkeeper-0.3.8
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	gnome2_src_prepare
	sed -i \
		-e '/^Encoding/d' \
		-e '/^Icon/s/\.png//' \
		editor/gtk/pioneers-editor.desktop.in \
		server/gtk/pioneers-server.desktop.in \
		client/gtk/pioneers.desktop.in \
		|| die

}

src_compile() {
	gnome2_src_compile $(use_enable nls)
}

src_install() {
	DOCS="AUTHORS ChangeLog README TODO NEWS" \
	gnome2_src_install scrollkeeper_localstate_dir="${D}"/var/lib/scrollkeeper/
}
