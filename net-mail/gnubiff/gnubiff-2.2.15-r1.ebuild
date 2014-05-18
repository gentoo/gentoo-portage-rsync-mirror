# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/gnubiff/gnubiff-2.2.15-r1.ebuild,v 1.1 2014/05/18 18:37:03 pacho Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="A mail notification program"
HOMEPAGE="http://gnubiff.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug fam gnome nls password"

RDEPEND=">=x11-libs/gtk+-3:3
	>=gnome-base/libglade-2.3
	dev-libs/popt
	password? ( dev-libs/openssl )
	fam? ( virtual/fam )
	gnome? ( >=gnome-base/gnome-panel-3.0 )
	x11-proto/xproto
	x11-libs/libX11
	x11-libs/pango
	x11-libs/gdk-pixbuf"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README THANKS TODO"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-fix-nls.patch \
		"${FILESDIR}"/${P}-gold.patch \
		"${FILESDIR}"/${P}-underlink.patch
	eautoreconf
}

src_configure() {
	# note: --disable-gnome is to avoid deprecated gnome-panel-2.x
	econf \
		$(use_enable debug) \
		$(use_enable gnome) \
		$(use_enable nls) \
		$(use_enable fam) \
		$(use_with password) \
		$(use_with password password-string ${RANDOM}${RANDOM}${RANDOM}${RANDOM})
}
