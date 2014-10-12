# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pioneers/pioneers-15.1-r1.ebuild,v 1.3 2014/10/12 08:50:06 ago Exp $

# NOTE: "QA Notice: Unrecognized configure options --with-gtk" is a false-positive

EAPI=5
inherit autotools eutils gnome-games

DESCRIPTION="A clone of the popular board game The Settlers of Catan"
HOMEPAGE="http://pio.sourceforge.net/"
SRC_URI="mirror://sourceforge/pio/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="dedicated help nls"

# dev-util/gob only for autoreconf
RDEPEND=">=dev-libs/glib-2.6:2
	!dedicated?	(
		>=x11-libs/gtk+-2.6:2
		x11-libs/libnotify
		help? (
			>=app-text/scrollkeeper-0.3.8
			>=gnome-base/libgnome-2.10
		)
	)
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-util/gob:2
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome-games_src_configure \
		$(use_enable nls) \
		--enable-minimal-flags \
		$(use_with help) \
		--includedir=/usr/include \
		$(use_with !dedicated gtk)
}

src_install() {
	DOCS="AUTHORS ChangeLog README TODO NEWS" \
	gnome2_src_install scrollkeeper_localstate_dir="${ED%/}"/var/lib/scrollkeeper/
	prepgamesdirs
}
