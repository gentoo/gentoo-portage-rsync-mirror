# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tomboy/tomboy-1.10.1.ebuild,v 1.6 2012/12/07 04:52:29 phajdan.jr Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools eutils gnome2 mono

DESCRIPTION="Desktop note-taking application"
HOMEPAGE="http://projects.gnome.org/tomboy/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="eds test"

RDEPEND="app-text/gtkspell:2
	dev-dotnet/gconf-sharp:2
	dev-dotnet/gtk-sharp:2
	dev-dotnet/mono-addins[gtk]
	dev-dotnet/dbus-sharp
	dev-dotnet/dbus-sharp-glib
	dev-lang/mono
	dev-libs/atk
	gnome-base/gconf:2
	x11-libs/gtk+:2
	eds? ( dev-libs/gmime:2.6[mono] )"
DEPEND="${RDEPEND}
	app-text/gnome-doc-utils
	app-text/rarian
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-panel-applet
		$(use_enable eds evolution)
		$(use_enable test tests)
		--disable-galago
		--disable-update-mimedb"
	DOCS="AUTHORS ChangeLog NEWS README"
}

src_prepare() {
	# Fix build with gmime-2.6[mono], bug #435854
	epatch "${FILESDIR}/${PN}-1.10.1-gmime26.patch"
	eautoreconf
}

src_compile() {
	# Not parallel build safe due upstream bug #631546
	MAKEOPTS="${MAKEOPTS} -j1" gnome2_src_compile
}
