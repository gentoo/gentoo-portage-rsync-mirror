# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rhythmbox/rhythmbox-0.13.3.ebuild,v 1.14 2012/12/20 15:58:46 tetromino Exp $

EAPI="3"
PYTHON_DEPEND="python? 2:2.5"

inherit eutils gnome2 python multilib virtualx

DESCRIPTION="Music management and playback software for GNOME"
HOMEPAGE="http://www.rhythmbox.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cdr daap gnome-keyring ipod +lastfm libnotify lirc musicbrainz mtp nsplugin python test udev upnp-av webkit"

# FIXME: double check what to do with fm-radio plugin
# TODO: watchout for udev use flag changes
COMMON_DEPEND=">=dev-libs/glib-2.26:2
	dev-libs/libxml2
	>=x11-libs/gtk+-2.20:2
	>=dev-libs/dbus-glib-0.71
	>=dev-libs/totem-pl-parser-2.32.1
	>=gnome-base/gconf-2
	>=gnome-extra/gnome-media-2.14
	<gnome-extra/gnome-media-2.91
	>=net-libs/libsoup-2.26:2.4
	>=net-libs/libsoup-gnome-2.26:2.4

	>=media-libs/gst-plugins-base-0.10.20:0.10
	|| (
		>=media-libs/gst-plugins-base-0.10.24:0.10
		>=media-libs/gst-plugins-bad-0.10.6:0.10 )

	app-misc/media-player-info

	cdr? ( >=app-cdr/brasero-0.9.1 )
	daap? (
		>=net-libs/libdmapsharing-2.1.6:2.2
		>=net-dns/avahi-0.6 )
	gnome-keyring? ( >=gnome-base/gnome-keyring-0.4.9 )
	udev? (
		virtual/udev[gudev]
		ipod? ( >=media-libs/libgpod-0.7.92 )
		mtp? ( >=media-libs/libmtp-0.3 ) )
	lastfm? ( dev-libs/json-glib )
	libnotify? ( >=x11-libs/libnotify-0.4.1 )
	lirc? ( app-misc/lirc )
	musicbrainz? ( media-libs/musicbrainz:3 )
	python? (
		|| (
			dev-lang/python:2.7
			dev-lang/python:2.6
			dev-lang/python:2.5
			dev-python/celementtree )
		>=dev-python/pygtk-2.8:2
		>=dev-python/pygobject-2.15.4:2
		>=dev-python/gconf-python-2.22
		>=dev-python/libgnome-python-2.22
		>=dev-python/gnome-keyring-python-2.22
		>=dev-python/gst-python-0.10.8:0.10
		webkit? (
			dev-python/mako
			dev-python/pywebkitgtk )
		upnp-av? ( media-video/coherence )
	)
	webkit? ( >=net-libs/webkit-gtk-1.1.7:2 )
"
RDEPEND="${COMMON_DEPEND}
	>=media-plugins/gst-plugins-soup-0.10:0.10
	>=media-plugins/gst-plugins-libmms-0.10:0.10
	|| (
		>=media-plugins/gst-plugins-cdparanoia-0.10:0.10
		>=media-plugins/gst-plugins-cdio-0.10:0.10 )
	>=media-plugins/gst-plugins-meta-0.10-r2:0.10
	>=media-plugins/gst-plugins-taglib-0.10.6:0.10
"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	dev-util/gtk-doc-am
	>=dev-util/intltool-0.40
	app-text/scrollkeeper
	>=app-text/gnome-doc-utils-0.9.1
	test? ( dev-libs/check )"

DOCS="AUTHORS ChangeLog DOCUMENTERS INTERNALS \
	  MAINTAINERS MAINTAINERS.old NEWS README THANKS"

pkg_setup() {
	if use python; then
		python_set_active_version 2
		python_pkg_setup
		G2CONF="${G2CONF} PYTHON=$(PYTHON -2)"
	fi

	if ! use udev; then
		if use ipod; then
			ewarn "ipod support requires udev support.  Please"
			ewarn "re-emerge with USE=udev to enable ipod support"
			G2CONF="${G2CONF} --without-ipod"
		fi

		if use mtp; then
			ewarn "MTP support requires udev support.  Please"
			ewarn "re-emerge with USE=udev to enable MTP support"
			G2CONF="${G2CONF} --without-mtp"
		fi
	else
		G2CONF="${G2CONF} $(use_with ipod) $(use_with mtp)"
	fi

	if ! use cdr ; then
		ewarn "You have cdr USE flag disabled."
		ewarn "You will not be able to burn CDs."
	else
		G2CONF="${G2CONF} $(use_with cdr libbrasero-media) --without-libnautilus-burn"
	fi

	if ! use python; then
		if use upnp-av; then
			ewarn "You need python support in addition to upnp-av"
		fi
	fi

	G2CONF="${G2CONF}
		MOZILLA_PLUGINDIR=/usr/$(get_libdir)/nsbrowser/plugins
		GST_INSPECT=$(type -P true)
		$(use_with gnome-keyring)
		$(use_with udev gudev)
		--without-hal
		$(use_enable lastfm)
		$(use_enable libnotify)
		$(use_enable lirc)
		$(use_enable musicbrainz)
		$(use_enable nsplugin browser-plugin)
		$(use_enable python)
		$(use_enable daap)
		$(use_with daap mdns avahi)
		$(use_with webkit)
		--enable-mmkeys
		--disable-scrollkeeper
		--disable-schemas-install
		--disable-static
		--disable-vala
		--disable-more-warnings"
}

src_prepare() {
	gnome2_src_prepare
	use python && python_clean_py-compile_files
}

src_compile() {
	addpredict "$(unset HOME; echo ~)/.gconf"
	addpredict "$(unset HOME; echo ~)/.gconfd"
	gnome2_src_compile
}

src_test() {
	unset SESSION_MANAGER
	unset DBUS_SESSION_BUS_ADDRESS
	Xemake check || die "test failed"
}

src_install() {
	gnome2_src_install

	find "${ED}/usr/$(get_libdir)/rhythmbox/plugins" -name "*.la" -delete \
		|| die "failed to remove *.la files"
}

pkg_postinst() {
	gnome2_pkg_postinst
	use python && python_mod_optimize /usr/$(get_libdir)/rhythmbox/plugins

	ewarn
	ewarn "If ${PN} doesn't play some music format, please check your"
	ewarn "USE flags on media-plugins/gst-plugins-meta"
	ewarn
}

pkg_postrm() {
	gnome2_pkg_postrm
	use python && python_mod_cleanup /usr/$(get_libdir)/rhythmbox/plugins
}
