# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/geoclue/geoclue-0.12.0_p20110307.ebuild,v 1.13 2012/09/11 14:01:50 armin76 Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="A geoinformation D-Bus service"
HOMEPAGE="http://freedesktop.org/wiki/Software/GeoClue"
SRC_URI="http://dev.gentoo.org/~signals/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ppc64 ~sparc x86 ~amd64-fbsd"
IUSE="geonames gps gsmloc gtk hostip manual networkmanager nominatim plazes
	skyhook yahoo-geo"

REQUIRED_USE="skyhook? ( networkmanager )"

RDEPEND="dev-libs/dbus-glib
	dev-libs/glib:2
	dev-libs/libxml2
	gnome-base/gconf
	skyhook? ( net-libs/libsoup )
	sys-apps/dbus
	gtk? ( x11-libs/gtk+:2 )
	gps? ( <=sci-geosciences/gpsd-2.95-r1 )
	networkmanager? ( net-misc/networkmanager )"
DEPEND="${RDEPEND}
	dev-util/gtk-doc
	dev-util/gtk-doc-am"

src_prepare() {
	epatch "${FILESDIR}"/${P}-use-flag.patch \
		"${FILESDIR}"/${P}-use-fallback-mac.patch
	sed -i -e 's/-Werror//' configure.ac || die #363723
	gtkdocize || die
	eautoreconf
}

src_configure() {
	# Conic is only for Maemo. Don't enable.
	# Gypsy has multiple vulnerabilities:
	# https://bugs.freedesktop.org/show_bug.cgi?id=33431
	econf \
		--disable-conic \
		--disable-gypsy \
		$(use_enable geonames) \
		$(use_enable gps gpsd) \
		$(use_enable gsmloc) \
		$(use_enable gtk) \
		$(use_enable hostip) \
		$(use_enable manual) \
		$(use_enable networkmanager) \
		$(use_enable nominatim) \
		$(use_enable plazes) \
		$(use_enable skyhook) \
		$(use_enable yahoo-geo yahoo)
}

src_install() {
	emake DESTDIR="${D}" install
	use gtk && dobin test/.libs/geoclue-test-gui
}
