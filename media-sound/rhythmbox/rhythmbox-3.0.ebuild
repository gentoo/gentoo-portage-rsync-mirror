# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rhythmbox/rhythmbox-3.0.ebuild,v 1.1 2013/09/13 09:16:13 nirbheek Exp $

EAPI="4"
GNOME2_LA_PUNT="yes"
PYTHON_DEPEND="python? 3:3.2"
PYTHON_USE_WITH="xml"
PYTHON_USE_WITH_OPT="python"

inherit eutils gnome2 python multilib virtualx

DESCRIPTION="Music management and playback software for GNOME"
HOMEPAGE="http://www.rhythmbox.org/"

LICENSE="GPL-2"
SLOT="0"
IUSE="cdr daap dbus doc +libsecret html ipod libnotify lirc mtp nsplugin +python
test +udev upnp-av visualizer webkit zeitgeist"
if [[ ${PV} = 9999 ]]; then
	KEYWORDS=""
else
	KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
fi

REQUIRED_USE="
	ipod? ( udev )
	mtp? ( udev )
	dbus? ( python )
	webkit? ( python )"

# FIXME: double check what to do with fm-radio plugin
# webkit-gtk-1.10 is needed because it uses gstreamer-1.0
COMMON_DEPEND=">=dev-libs/glib-2.34.0:2
	dev-libs/json-glib
	>=dev-libs/libxml2-2.7.8:2
	>=x11-libs/gtk+-3.6:3[introspection]
	>=x11-libs/gdk-pixbuf-2.18.0:2
	>=dev-libs/gobject-introspection-0.10.0
	>=dev-libs/libpeas-0.7.3[gtk,python?]
	>=dev-libs/totem-pl-parser-3.2.0
	>=net-libs/libsoup-2.26:2.4
	>=net-libs/libsoup-gnome-2.26:2.4
	>=media-libs/gst-plugins-base-0.11.92:1.0[introspection]
	>=media-libs/gstreamer-1.0.0:1.0[introspection]
	>=sys-libs/tdb-1.2.6

	visualizer? (
		>=media-libs/clutter-1.8:1.0
		>=media-libs/clutter-gst-1.9.92:2.0
		>=media-libs/clutter-gtk-1.0:1.0
		>=x11-libs/mx-1.0.1:1.0
		media-plugins/gst-plugins-libvisual:1.0 )
	cdr? ( >=app-cdr/brasero-2.91.90 )
	daap? (
		>=net-libs/libdmapsharing-2.9.16:3.0
		media-plugins/gst-plugins-soup:1.0 )
	libsecret? ( >=app-crypt/libsecret-0.14 )
	html? ( >=net-libs/webkit-gtk-1.10:3 )
	libnotify? ( >=x11-libs/libnotify-0.7.0 )
	lirc? ( app-misc/lirc )
	python? ( >=dev-python/pygobject-3.0:3 )
	udev? (
		virtual/udev[gudev]
		ipod? ( >=media-libs/libgpod-0.7.92[udev] )
		mtp? ( >=media-libs/libmtp-0.3 ) )
	zeitgeist? ( gnome-extra/zeitgeist )
"
RDEPEND="${COMMON_DEPEND}
	media-plugins/gst-plugins-soup:1.0
	media-plugins/gst-plugins-libmms:1.0
	|| (
		media-plugins/gst-plugins-cdparanoia:1.0
		media-plugins/gst-plugins-cdio:1.0 )
	media-plugins/gst-plugins-meta:1.0
	media-plugins/gst-plugins-taglib:1.0
	x11-themes/gnome-icon-theme-symbolic
	upnp-av? (
		>=media-libs/grilo-0.2:0.2
		>=media-plugins/grilo-plugins-0.2:0.2[upnp-av] )
	python? (
		x11-libs/gdk-pixbuf:2[introspection]
		x11-libs/gtk+:3[introspection]
		x11-libs/pango[introspection]

		dbus? ( sys-apps/dbus )
		libsecret? ( >=app-crypt/libsecret-0.14[introspection] )
		webkit? (
			dev-python/mako
			>=net-libs/webkit-gtk-1.10:3[introspection] ) )
"
# gtk-doc-am needed for eautoreconf
#	dev-util/gtk-doc-am
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	app-text/yelp-tools
	>=dev-util/intltool-0.35
	>=app-text/gnome-doc-utils-0.9.1
	doc? ( >=dev-util/gtk-doc-1.4 )
	test? ( dev-libs/check )"
DOCS="AUTHORS ChangeLog DOCUMENTERS INTERNALS \
	  MAINTAINERS MAINTAINERS.old NEWS README THANKS"

pkg_setup() {
	if use python; then
		python_set_active_version 3
		python_pkg_setup
		G2CONF="${G2CONF} PYTHON=$(PYTHON -3)"
	fi

	# --enable-vala just installs the sample vala plugin, and the configure
	# checks are broken, so don't enable it
	G2CONF="${G2CONF}
		MOZILLA_PLUGINDIR=/usr/$(get_libdir)/nsbrowser/plugins
		--enable-mmkeys
		--disable-more-warnings
		--disable-schemas-compile
		--disable-static
		--disable-vala
		--without-hal
		$(use_enable visualizer)
		$(use_enable daap)
		$(use_enable libnotify)
		$(use_enable lirc)
		$(use_enable nsplugin browser-plugin)
		$(use_enable python)
		$(use_enable upnp-av grilo)
		$(use_with cdr brasero)
		$(use_with daap)
		$(use_with libsecret)
		$(use_with html webkit)
		$(use_with ipod)
		$(use_with mtp)
		$(use_with udev gudev)"

	export GST_INSPECT=/bin/true
}

src_prepare() {
	gnome2_src_prepare
	echo > py-compile
}

src_test() {
	unset SESSION_MANAGER
	unset DBUS_SESSION_BUS_ADDRESS
	Xemake check || die "test failed"
}

pkg_postinst() {
	gnome2_pkg_postinst
	if use python; then
		python_need_rebuild
		python_mod_optimize /usr/$(get_libdir)/rhythmbox/plugins
	fi

	ewarn
	ewarn "If ${PN} doesn't play some music format, please check your"
	ewarn "USE flags on media-plugins/gst-plugins-meta:1.0"
	ewarn
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup /usr/$(get_libdir)/rhythmbox/plugins
}
