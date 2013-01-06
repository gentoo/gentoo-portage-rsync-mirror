# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/kildclient/kildclient-2.9.0.ebuild,v 1.7 2012/05/03 03:32:33 jdhore Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="Powerful MUD client with a built-in PERL interpreter"
HOMEPAGE="http://kildclient.sourceforge.net"
SRC_URI="mirror://sourceforge/kildclient/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="doc gnutls spell"

RDEPEND="x11-libs/gtk+:2
	gnome-base/libglade
	dev-lang/perl
	sys-libs/zlib
	virtual/libintl
	spell? ( app-text/gtkspell:2 )
	gnutls? ( net-libs/gnutls )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch \
		"${FILESDIR}"/${P}-underlink.patch
	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--localedir=/usr/share/locale \
		--docdir=/usr/share/doc/${PF} \
		--htmldir=/usr/share/doc/${PF}/html \
		$(use_with spell gtkspell) \
		$(use_with gnutls libgnutls) \
		$(use_with doc docs)
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
	prepgamesdirs
}
