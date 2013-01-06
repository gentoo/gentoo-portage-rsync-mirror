# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/grhino/grhino-0.16.1.ebuild,v 1.3 2010/10/10 18:54:47 fauli Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Reversi game for GNOME, supporting the Go/Game Text Protocol"
HOMEPAGE="http://rhino.sourceforge.net/"
SRC_URI="mirror://sourceforge/rhino/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gnome gtp nls"

RDEPEND="gnome? ( =gnome-base/libgnomeui-2* )
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_prepare() {
	sed -i '/^(\|locale\|help\|omf\|icon\|)/s:@datadir@:/usr/share:' \
		Makefile.in \
		|| die "sed failed"
}

src_configure() {
	if use gnome || use gtp; then
		egamesconf \
			--localedir=/usr/share/locale \
			$(use_enable gnome) \
			$(use_enable gtp) \
			$(use_enable nls)
	else
		egamesconf \
			--localedir=/usr/share/locale \
			--enable-gtp \
			--disable-gnome \
			$(use_enable nls)
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc ChangeLog NEWS README TODO

	if use gnome; then
		make_desktop_entry ${PN} GRhino
	fi

	prepgamesdirs
}
