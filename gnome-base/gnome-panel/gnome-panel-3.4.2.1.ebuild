# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-panel/gnome-panel-3.4.2.1.ebuild,v 1.2 2012/10/16 03:47:52 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools eutils gnome2

DESCRIPTION="The GNOME panel"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2+ FDL-1.1+ LGPL-2+"
SLOT="0"
IUSE="eds +introspection networkmanager"
# Odd behaviour w.r.t. panels: https://bugzilla.gnome.org/show_bug.cgi?id=631553
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"

RDEPEND=">=dev-libs/glib-2.31.14:2
	>=dev-libs/libgweather-2.91:2
	dev-libs/libxml2:2
	gnome-base/dconf
	>=gnome-base/gconf-2.6.1:2[introspection?]
	>=gnome-base/gnome-desktop-2.91:3
	>=gnome-base/gnome-menus-3.1.4:3
	gnome-base/gsettings-desktop-schemas
	gnome-base/librsvg:2
	>=net-libs/telepathy-glib-0.14.0
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

	eds? ( >=gnome-extra/evolution-data-server-2.91.2 )
	introspection? ( >=dev-libs/gobject-introspection-0.9.5 )
	networkmanager? ( >=net-misc/networkmanager-0.6.7 )"
DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.1.2
	>=app-text/gnome-doc-utils-0.3.2
	>=dev-lang/perl-5
	dev-util/gtk-doc-am
	>=dev-util/intltool-0.40
	virtual/pkgconfig

	dev-libs/gobject-introspection-common
	gnome-base/gnome-common"
# eautoreconf needs
#	dev-libs/gobject-introspection-common
#	gnome-base/gnome-common

pkg_setup() {
	# XXX: Make presence/telepathy-glib support optional?
	#      We can do that if we intend to support fallback-only as a setup
	G2CONF="${G2CONF}
		--disable-deprecation-flags
		--disable-static
		--disable-scrollkeeper
		--disable-schemas-install
		--disable-schemas-compile
		--with-in-process-applets=clock,notification-area,wncklet
		--enable-telepathy-glib
		$(use_enable networkmanager network-manager)
		$(use_enable introspection)
		$(use_enable eds)"
	DOCS="AUTHORS ChangeLog HACKING NEWS README"
}

src_prepare() {
	epatch "${FILESDIR}/${P}-gold.patch"
	eautoreconf
	gnome2_src_prepare
}

pkg_postinst() {
	local entries="${EROOT}etc/gconf/schemas/panel-default-setup.entries"
	local gconftool="${EROOT}usr/bin/gconftool-2"

	if [ -e "$entries" ]; then
		einfo "Setting panel gconf defaults..."

		GCONF_CONFIG_SOURCE="$("${gconftool}" --get-default-source | sed "s;:/;:${ROOT};")"

		"${gconftool}" --direct --config-source \
			"${GCONF_CONFIG_SOURCE}" --load="${entries}"
	fi

	# Calling this late so it doesn't process the GConf schemas file we already
	# took care of.
	gnome2_pkg_postinst
}
