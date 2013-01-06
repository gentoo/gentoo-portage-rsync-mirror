# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tsclient/tsclient-2.0.1-r1.ebuild,v 1.5 2012/06/25 00:38:39 tetromino Exp $

EAPI=2

inherit eutils autotools

DESCRIPTION="GTK2 frontend for rdesktop"
HOMEPAGE="http://sourceforge.net/projects/tsclient"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# Too broken upstream to support
RESTRICT=test

RDEPEND="x11-libs/gtk+:2
	dev-libs/glib:2
	gnome-base/libglade:2.0
	gnome-base/libgnome
	gnome-base/libgnomeui
	gnome-base/gnome-desktop:2
	x11-libs/libnotify"

DEPEND="${RDEPEND}
	gnome-base/gconf
	>=dev-util/intltool-0.27
	virtual/pkgconfig"

RDEPEND="${RDEPEND}
	>=net-misc/rdesktop-1.3.0"

src_prepare() {
	# Fix .desktop file as per upstream changes, bug #351386
	epatch "${FILESDIR}"/${P}-no-networkmanager.patch \
		"${FILESDIR}"/${P}-libnotify-0.7.patch \
		"${FILESDIR}"/${P}-desktop-file.patch \
		"${FILESDIR}"/${P}-glib-2.32.patch

	# For recent libgnomeui
	sed -i -e 's:libgnome-2\.0:\0 libgnomeui-2\.0:' \
		configure.ac || die

	# don't seem to be actually needed
	sed -i -e 's:libnotify gconf-2.0::' \
		configure.ac || die

	eautoreconf
}

src_configure() {
	econf \
		--disable-static \
		--disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS NEWS README TODO || die

	find "${D}" -name '*.la' -delete || die

	# Don't install headers since we don't have any plugin that uses
	# tsclient. If upstream ever release further plugins we'll restore
	# them, but for now it seems like they just use a single plugin
	# for the sake of it.
	rm -r "${D}"/usr/include || die
}
