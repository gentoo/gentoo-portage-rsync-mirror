# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-applets/gnome-applets-3.4.1.ebuild,v 1.4 2012/12/10 01:58:41 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="no" # bug 340725, no other la files
PYTHON_DEPEND="2:2.5"

inherit eutils gnome2 python

DESCRIPTION="Applets for the GNOME Desktop and Panel"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
IUSE="gnome ipv6 networkmanager policykit"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux"

# null applet still needs bonobo support for gnome-panel?
#
# Latest gnome-panel needed due to commit 45a4988a6
# atk, cairo, pango used in multiple applets
RDEPEND=">=x11-libs/gtk+-3.0.0:3
	dev-libs/atk
	>=dev-libs/glib-2.22:2
	>=gnome-base/gconf-2.8:2
	>=gnome-base/gnome-panel-2.91.91
	x11-libs/cairo
	>=x11-libs/libxklavier-4.0
	>=x11-libs/libwnck-2.91.0:3
	>=x11-libs/libnotify-0.7
	x11-libs/pango
	>=sys-apps/dbus-1.1.2
	>=dev-libs/dbus-glib-0.74
	>=dev-libs/libxml2-2.5.0
	>=x11-themes/gnome-icon-theme-2.15.91
	>=dev-libs/libgweather-2.91.0
	x11-libs/libX11

	gnome?	(
		gnome-base/gnome-settings-daemon

		>=gnome-extra/gucharmap-2.33.0:2.90
		>=gnome-base/libgtop-2.11.92

		dev-python/pygobject:3
		gnome-base/gconf[introspection]
		gnome-base/gnome-panel[introspection]
		x11-libs/gdk-pixbuf[introspection]
		x11-libs/gtk+:3[introspection]
		x11-libs/pango[introspection] )
	networkmanager? ( >=net-misc/networkmanager-0.7.0 )
	policykit? ( >=sys-auth/polkit-0.92 )"
DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.1.2
	app-text/docbook-xml-dtd:4.3
	>=app-text/gnome-doc-utils-0.3.2
	>=app-text/scrollkeeper-0.1.4
	>=dev-util/intltool-0.35
	dev-libs/libxslt
	virtual/pkgconfig"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	DOCS="AUTHORS ChangeLog NEWS README"
	# We don't want HAL or battstat.
	# mixer applet uses gstreamer, conflicts with the mixer provided by g-s-d
	# GNOME 3 has a hard-dependency on pulseaudio, so gstmixer applet is useless
	G2CONF="${G2CONF}
		--disable-scrollkeeper
		--disable-schemas-install
		--without-hal
		--disable-battstat
		--disable-mixer-applet
		$(use_enable ipv6)
		$(use_enable networkmanager)
		$(use_enable policykit polkit)"

	# Remove silly check for pygobject:2
	# https://bugzilla.gnome.org/show_bug.cgi?id=660550
	sed -e 's/pygobject-2.0/pygobject-3.0/' -i configure || die "sed failed"
	gnome2_src_prepare

	python_clean_py-compile_files

	# Invest applet tests need gconf/proxy/...
	# Note: for now, invest tests are commented out by upstream
	#sed 's/^TESTS.*/TESTS=/g' -i invest-applet/invest/Makefile.am \
	#	invest-applet/invest/Makefile.in || die "disabling invest tests failed"

	python_convert_shebangs -r 2 .
}

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	emake check
}

src_install() {
	gnome2_src_install

	local APPLETS="accessx-status charpick cpufreq drivemount geyes
			 gweather invest-applet mini-commander
			 multiload null_applet stickynotes trashapplet"

	# mixer is out because gnome3 uses pulseaudio
	# modemlights is out because it needs system-tools-backends-1
	# battstat is disabled because we don't want HAL anywhere

	for applet in ${APPLETS} ; do
		docinto ${applet}

		for d in AUTHORS ChangeLog NEWS README README.themes TODO ; do
			[ -s ${applet}/${d} ] && dodoc ${applet}/${d}
		done
	done
}

pkg_postinst() {
	gnome2_pkg_postinst

	# check for new python modules on bumps
	python_mod_optimize invest
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup invest
}
