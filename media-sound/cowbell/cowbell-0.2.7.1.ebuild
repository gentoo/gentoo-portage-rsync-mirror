# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cowbell/cowbell-0.2.7.1.ebuild,v 1.11 2012/05/21 23:29:39 vapier Exp $

EAPI=2

GCONF_DEBUG=no

inherit autotools gnome2 mono eutils

DESCRIPTION="Elegantly tag and rename mp3/ogg/flac files"
HOMEPAGE="http://more-cowbell.org"
SRC_URI="http://more-cowbell.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/mono
	>=dev-dotnet/gtk-sharp-2.6
	>=dev-dotnet/glade-sharp-2.6
	>=media-libs/taglib-1.4"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.34.2"

DOCS="AUTHORS ChangeLog NEWS README"

MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	gnome2_src_prepare
	epatch "${FILESDIR}"/${P}-libtool.patch \
		"${FILESDIR}"/${P}-desktop-entry.patch
	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}

src_configure() {
	gnome2_src_configure
}

src_compile() {
	default
}
