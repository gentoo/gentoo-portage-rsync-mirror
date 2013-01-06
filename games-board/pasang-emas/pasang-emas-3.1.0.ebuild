# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pasang-emas/pasang-emas-3.1.0.ebuild,v 1.4 2012/01/21 16:32:36 phajdan.jr Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A traditional game of Brunei"
HOMEPAGE="http://pasang-emas.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
	extras? ( mirror://sourceforge/${PN}/pasang-emas-themes-1.0.tar.bz2
	          mirror://sourceforge/${PN}/pet-marble.tar.bz2
	          mirror://sourceforge/${PN}/pet-fragrance.tar.bz2 )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="extras nls"

RDEPEND="app-text/gnome-doc-utils
	>=x11-libs/gtk+-2.18.2:2
	virtual/libintl
	app-text/scrollkeeper"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
	sed -i \
		-e '/Encoding/d' \
		-e '/Icon/s:\.png::' \
		data/pasang-emas.desktop.in \
		|| die
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--localedir=/usr/share/locale \
		--with-omf-dir=/usr/share/omf \
		--with-help-dir=/usr/share/gnome/help \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die
	if use extras; then
		insinto "${GAMES_DATADIR}/${PN}"/themes
		doins -r \
			"${WORKDIR}"/marble \
			"${WORKDIR}"/pasang-emas-themes-1.0/{conteng,kaca} \
			"${WORKDIR}"/fragrance || die
	fi
	use nls || rm -rf "${D}"usr/share/locale
	prepgamesdirs
}
