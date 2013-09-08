# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-panel/gnome-panel-3.6.2-r1.ebuild,v 1.3 2013/09/08 17:53:29 eva Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools gnome2 eutils

DESCRIPTION="The GNOME panel"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2+ FDL-1.1+ LGPL-2+"
SLOT="0"
IUSE="eds +introspection networkmanager"
# Odd behaviour w.r.t. panels: https://bugzilla.gnome.org/show_bug.cgi?id=631553
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"

RDEPEND="
	>=dev-libs/glib-2.31.14:2
	>=dev-libs/libgweather-3.5.1:2=
	dev-libs/libxml2:2
	>=gnome-base/dconf-0.13.4
	>=gnome-base/gconf-2.6.1:2[introspection?]
	>=gnome-base/gnome-desktop-2.91:3=
	>=gnome-base/gnome-menus-3.1.4:3
	gnome-base/gsettings-desktop-schemas
	gnome-base/librsvg:2
	>=net-libs/telepathy-glib-0.14
	sys-auth/polkit
	>=x11-libs/cairo-1[X]
	>=x11-libs/gdk-pixbuf-2.25.2:2
	>=x11-libs/gtk+-3.3.8:3[introspection?]
	x11-libs/libXau
	x11-libs/libICE
	x11-libs/libSM
	>=x11-libs/libXrandr-1.2
	>=x11-libs/libwnck-2.91:3
	>=x11-libs/pango-1.15.4[introspection?]

	eds? ( >=gnome-extra/evolution-data-server-3.5.3:= )
	introspection? ( >=dev-libs/gobject-introspection-0.9.5 )
	networkmanager? ( >=net-misc/networkmanager-0.6.7 )
"
DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.1.2
	app-text/yelp-tools
	>=dev-lang/perl-5
	dev-util/gtk-doc-am
	>=dev-util/intltool-0.40
	virtual/pkgconfig
"
# eautoreconf needs
#	dev-libs/gobject-introspection-common
#	gnome-base/gnome-common

src_prepare() {
	# Upstream patches committed to master
	# Fix launcher icon animation ending with black artifact
	epatch "${FILESDIR}/${P}-fix-animation.patch"

	# Fix build error due to missing gweather-xml.h
	epatch "${FILESDIR}/${P}-gweather-include.patch"

	# Apply style after realize
	epatch "${FILESDIR}/${P}-fix-black.patch"

	# Drop support for commandline-based calendar/tasks applications
	epatch "${FILESDIR}/${P}-drop-commandline.patch"

	# Resurrect function gnome_desktop_prepend_terminal_to_vector
	epatch "${FILESDIR}/${P}-resurrect-function.patch"

	# Rename helper function
	epatch "${FILESDIR}/${P}-rename-function.patch"

	# Use the generic marshaller
	epatch "${FILESDIR}/${P}-generic-marshaller.patch"

	# automake-1.13 fix, bug #479890
	sed -i -e 's|AM_CONFIG_HEADER|AC_CONFIG_HEADERS|g' configure.ac || die

	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	DOCS="AUTHORS ChangeLog HACKING NEWS README"

	# XXX: Make presence/telepathy-glib support optional?
	#      We can do that if we intend to support fallback-only as a setup
	gnome2_src_configure \
		--disable-deprecation-flags \
		--disable-static \
		--with-in-process-applets=clock,notification-area,wncklet \
		--enable-telepathy-glib \
		$(use_enable networkmanager network-manager) \
		$(use_enable introspection) \
		$(use_enable eds) \
		ITSTOOL=$(type -P true)
}
