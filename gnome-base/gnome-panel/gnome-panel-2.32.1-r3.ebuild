# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-panel/gnome-panel-2.32.1-r3.ebuild,v 1.12 2012/10/16 03:47:52 tetromino Exp $

EAPI="3"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_DEPEND="2:2.5"

inherit gnome2 python eutils autotools

DESCRIPTION="The GNOME panel"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="${SRC_URI} mirror://gentoo/introspection-20110205.m4.tar.bz2
	http://dev.gentoo.org/~pacho/gnome/${P}-patches.tar.bz2"

LICENSE="GPL-2+ FDL-1.1+ LGPL-2+"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="+bonobo eds +introspection networkmanager"

RDEPEND=">=gnome-base/gnome-desktop-2.26:2
	>=x11-libs/pango-1.15.4[introspection?]
	>=dev-libs/glib-2.25.12:2
	>=x11-libs/gtk+-2.22:2[introspection?]
	>=dev-libs/libgweather-2.27.90:2
	<dev-libs/libgweather-2.90.1:2
	dev-libs/libxml2:2
	>=gnome-base/gconf-2.6.1:2[introspection?]
	>=media-libs/libcanberra-0.23[gtk]
	>=gnome-base/gnome-menus-2.27.92:0
	gnome-base/librsvg:2
	>=dev-libs/dbus-glib-0.80
	>=sys-apps/dbus-1.1.2
	>=x11-libs/cairo-1
	x11-libs/libXau
	>=x11-libs/libXrandr-1.2
	bonobo? (
		>=gnome-base/libbonobo-2.20.4
		>=gnome-base/libbonoboui-2.1.1
		>=gnome-base/orbit-2.4
		>=x11-libs/libwnck-2.19.5:1 )
	eds? ( >=gnome-extra/evolution-data-server-1.6 )
	introspection? ( >=dev-libs/gobject-introspection-0.6.7 )
	networkmanager? ( >=net-misc/networkmanager-0.6.7 )"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	dev-util/gtk-doc-am
	>=app-text/gnome-doc-utils-0.3.2
	virtual/pkgconfig
	>=dev-util/intltool-0.40
	app-text/docbook-xml-dtd:4.1.2
	gnome-base/gnome-common"
# eautoreconf needs
#	gnome-base/gnome-common

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-deprecation-flags
		--disable-static
		--disable-scrollkeeper
		--disable-schemas-install
		$(use_enable bonobo)
		$(use_enable networkmanager network-manager)
		$(use_enable introspection)
		$(use_enable eds)"
	DOCS="AUTHORS ChangeLog HACKING NEWS README"
	python_set_active_version 2
}

src_unpack() {
	# If gobject-introspection is installed, we don't need the extra .m4
	if has_version "dev-libs/gobject-introspection"; then
		unpack ${P}.tar.bz2 ${P}-patches.tar.bz2
	else
		unpack ${A}
	fi
}

src_prepare() {
	# List the objects before the libraries to fix build with --as-needed
	epatch "${FILESDIR}/${P}-as-needed.patch"

	# Try to improve panel behavior on multiscreen systems, bug #348253, upstream #632369
	epatch "${FILESDIR}/${PN}-2.32.1-fix-multiscreen.patch"
	epatch "${FILESDIR}/${PN}-2.32.1-fix-multiscreen2.patch"

	# Apply multiple bugfixes from 2.32 and master branches
	# Also use gnome-applications.menu instead of applications.menu as it's the default value for us.
	epatch "${WORKDIR}/${P}-patches"/*.patch

	# clock applet: Pass the correct month to Evolution command line
	epatch "${FILESDIR}/${PN}-2.32.1-evo-month.patch"

	# Fix underlinking, bug #384533
	epatch "${FILESDIR}/${P}-underlinking.patch"

	AT_M4DIR=${WORKDIR} eautoreconf
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
