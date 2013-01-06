# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/f-spot/f-spot-0.8.2.ebuild,v 1.9 2012/05/05 07:00:25 jdhore Exp $

EAPI="2"

inherit gnome2 mono eutils autotools multilib

DESCRIPTION="Personal photo management application for the gnome desktop"
HOMEPAGE="http://f-spot.org"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc flickr raw"

RDEPEND=">=dev-lang/mono-2.2
	>=gnome-base/libgnome-2.2
	>=gnome-base/libgnomeui-2.2
	dev-dotnet/gnome-keyring-sharp
	>=dev-dotnet/gtk-sharp-2.12.2:2
	>=dev-dotnet/glib-sharp-2.12.2:2
	>=x11-libs/gtk+-2.16:2
	>=dev-libs/glib-2.22:2
	>=dev-libs/libunique-1.0:1
	>=dev-dotnet/gnome-sharp-2.8:2
	>=dev-dotnet/glib-sharp-2.12:2
	>=dev-dotnet/gconf-sharp-2.20.2:2
	>=dev-dotnet/mono-addins-0.3[gtk]
	>=dev-libs/dbus-glib-0.71
	>=dev-dotnet/ndesk-dbus-0.4.2
	>=dev-dotnet/ndesk-dbus-glib-0.3.0
	>=media-libs/lcms-1.12:0
	>=x11-libs/cairo-1.4
	doc? (	virtual/monodoc
		>=app-text/gnome-doc-utils-0.17.3 )
	flickr? ( >=dev-dotnet/flickrnet-bin-2.2-r1 )
	raw?	( media-gfx/dcraw )"

DEPEND="${RDEPEND}
	>=dev-dotnet/gtk-sharp-gapi-2.12.2
	>=app-text/gnome-doc-utils-0.17.3
	virtual/pkgconfig
	>=dev-util/intltool-0.35"

pkg_setup() {
	DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"
	G2CONF="${G2CONF}
		--disable-static
		--disable-scrollkeeper
		$(use_enable doc user-help)"
}

src_prepare() {
	gnome2_src_prepare

	# Fix compiler error CS1501 building FSpot.Loaders on mono 2.8, upstream bug #629224
	epatch "${FILESDIR}/${PN}-0.8.1-mono2.8.patch"

	sed  -r -i -e 's:-D[A-Z]+_DISABLE_DEPRECATED::g' \
		lib/libfspot/Makefile.am || die

	if ! use flickr; then
		sed -i -e '/FSpot.Exporters.Flickr/d' src/Extensions/Exporters/Makefile.am || die
		sed -i -e '/FSPOT_CHECK_FLICKRNET/d' configure.ac || die
	fi

	intltoolize --force --automake --copy || die "intltoolized failed"
	AT_M4DIR="build/m4/f-spot build/m4/shamrock build/m4/shave" eautoreconf
}

src_install() {
	gnome2_src_install
	find "${D}" -name '*.la' -delete || die "la removal failed"
}
