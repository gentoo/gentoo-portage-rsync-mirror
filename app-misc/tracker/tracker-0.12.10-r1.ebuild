# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tracker/tracker-0.12.10-r1.ebuild,v 1.5 2013/03/02 19:33:02 hwoarang Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_DEPEND="2:2.6"

inherit eutils gnome2 linux-info multilib python versionator

DESCRIPTION="A tagging metadata database, search tool and indexer"
HOMEPAGE="http://projects.gnome.org/tracker/"

LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# USE="doc" is managed by eclass.
IUSE="applet doc eds elibc_glibc exif firefox-bookmarks flac flickr gif
gnome-keyring gsf gstreamer gtk iptc +jpeg laptop mp3 nautilus networkmanager pdf playlist rss test thunderbird +tiff upnp-av +vorbis xine +xml xmp" # qt4 strigi

# Test suite highly disfunctional, loops forever
# putting aside for now
RESTRICT="test"

# vala is built with debug by default (see VALAFLAGS)
# According to NEWS, introspection is non-optional
# glibc-2.12 needed for SCHED_IDLE (see bug #385003)
RDEPEND="
	>=app-i18n/enca-1.9
	>=dev-db/sqlite-3.7[threadsafe]
	>=dev-libs/glib-2.28:2
	>=dev-libs/gobject-introspection-0.9.5
	>=dev-libs/icu-4
	|| (
		>=media-gfx/imagemagick-5.2.1[png,jpeg=]
		media-gfx/graphicsmagick[imagemagick,png,jpeg=] )
	>=media-libs/libpng-1.2
	>=x11-libs/pango-1
	sys-apps/util-linux

	applet? (
		>=gnome-base/gnome-panel-2.91.6
		>=x11-libs/gdk-pixbuf-2.12:2
		>=x11-libs/gtk+-3.0:3 )
	eds? (
		>=mail-client/evolution-2.91.90
		>=gnome-extra/evolution-data-server-2.91.90
		<mail-client/evolution-3.5.3
		<gnome-extra/evolution-data-server-3.5.3 )
	elibc_glibc? ( >=sys-libs/glibc-2.12 )
	exif? ( >=media-libs/libexif-0.6 )
	firefox-bookmarks? ( || (
		>=www-client/firefox-4.0
		>=www-client/firefox-bin-4.0 ) )
	flac? ( >=media-libs/flac-1.2.1 )
	flickr? ( net-libs/rest:0.7 )
	gif? ( media-libs/giflib )
	gnome-keyring? ( >=gnome-base/gnome-keyring-2.26 )
	gsf? ( >=gnome-extra/libgsf-1.13 )
	gstreamer? (
		>=media-libs/gstreamer-0.10.31:0.10
		upnp-av? ( >=media-libs/gupnp-dlna-0.5 )
		!upnp-av? ( >=media-libs/gst-plugins-base-0.10.31:0.10 ) )
	!gstreamer? ( !xine? ( || ( media-video/totem media-video/mplayer ) ) )
	gtk? (
		>=dev-libs/libgee-0.3:0
		>=x11-libs/gtk+-3.0.0:3 )
	iptc? ( media-libs/libiptcdata )
	jpeg? ( virtual/jpeg:0 )
	laptop? ( >=sys-power/upower-0.9 )
	mp3? (
		>=media-libs/taglib-1.6
		gtk? ( x11-libs/gdk-pixbuf:2 ) )
	networkmanager? ( >=net-misc/networkmanager-0.8 )
	pdf? (
		>=x11-libs/cairo-1
		>=app-text/poppler-0.16[cairo,utils]
		>=x11-libs/gtk+-2.12:2 )
	playlist? ( dev-libs/totem-pl-parser )
	rss? ( net-libs/libgrss )
	thunderbird? ( || (
		>=mail-client/thunderbird-5.0
		>=mail-client/thunderbird-bin-5.0 ) )
	tiff? ( media-libs/tiff )
	vorbis? ( >=media-libs/libvorbis-0.22 )
	xine? ( >=media-libs/xine-lib-1 )
	xml? ( >=dev-libs/libxml2-2.6 )
	xmp? ( >=media-libs/exempi-2.1 )"
#	strigi? ( >=app-misc/strigi-0.7 )
#	mp3? ( qt4? (  >=dev-qt/qtgui-4.7.1:4 ) )
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
	applet? ( >=dev-lang/vala-0.12:0.12 )
	gtk? (
		>=dev-lang/vala-0.12:0.12
		>=dev-libs/libgee-0.3 )
	doc? (
		app-office/dia
		>=dev-util/gtk-doc-1.8
		media-gfx/graphviz )
	test? (
		>=dev-libs/dbus-glib-0.82-r1
		>=sys-apps/dbus-1.3.1[X] )
"
#	strigi? ( >=dev-lang/vala-0.12:0.12 )
PDEPEND="nautilus? ( >=gnome-extra/nautilus-tracker-tags-0.12.7 )"

function inotify_enabled() {
	if linux_config_exists; then
		if ! linux_chkconfig_present INOTIFY_USER; then
			ewarn "You should enable the INOTIFY support in your kernel."
			ewarn "Check the 'Inotify support for userland' under the 'File systems'"
			ewarn "option. It is marked as CONFIG_INOTIFY_USER in the config"
			die 'missing CONFIG_INOTIFY'
		fi
	else
		einfo "Could not check for INOTIFY support in your kernel."
	fi
}

pkg_setup() {
	linux-info_pkg_setup

	inotify_enabled

	if use gstreamer ; then
		G2CONF="${G2CONF} --enable-generic-media-extractor=gstreamer"
		if use upnp-av; then
			G2CONF="${G2CONF} --with-gstreamer-backend=gupnp-dlna"
		else
			G2CONF="${G2CONF} --with-gstreamer-backend=discoverer"
		fi
	elif use xine ; then
		G2CONF="${G2CONF} --enable-generic-media-extractor=xine"
	else
		G2CONF="${G2CONF} --enable-generic-media-extractor=external"
	fi

	# if use applet || use gtk || use strigi; then
	if use applet || use gtk; then
		G2CONF="${G2CONF} VALAC=$(type -P valac-0.12)"
	fi

	# if use mp3 && (use gtk || use qt4); then
	if use mp3 && use gtk; then
		#G2CONF="${G2CONF} $(use_enable !qt4 gdkpixbuf) $(use_enable qt4 qt)"
		G2CONF="${G2CONF} --enable-gdkpixbuf"
	fi

	# unicode-support: libunistring, libicu or glib ?
	# According to NEWS, introspection is required
	# FIXME: disabling streamanalyzer for now since tracker-sparql-builder.h
	# is not being generated
	# XXX: disabling qt since tracker-albumart-qt is unstable; bug #385345
	# nautilus extension is in a separate package, nautilus-tracker-tags
	G2CONF="${G2CONF}
		--disable-hal
		--disable-libcue
		--enable-tracker-fts
		--with-enca
		--with-unicode-support=libicu
		--enable-guarantee-metadata
		--enable-introspection
		--disable-libstreamanalyzer
		--disable-qt
		--disable-nautilus-extension
		$(use_enable applet tracker-search-bar)
		$(use_enable eds miner-evolution)
		$(use_enable exif libexif)
		$(use_enable firefox-bookmarks miner-firefox)
		$(use_with firefox-bookmarks firefox-plugin-dir ${EPREFIX}/usr/$(get_libdir)/firefox/extensions)
		FIREFOX=${S}/firefox-version.sh
		$(use_enable flac libflac)
		$(use_enable flickr miner-flickr)
		$(use_enable gnome-keyring)
		$(use_enable gsf libgsf)
		$(use_enable gtk tracker-explorer)
		$(use_enable gtk tracker-preferences)
		$(use_enable gtk tracker-needle)
		$(use_enable iptc libiptcdata)
		$(use_enable jpeg libjpeg)
		$(use_enable laptop upower)
		$(use_enable mp3 taglib)
		$(use_enable networkmanager network-manager)
		$(use_enable pdf poppler)
		$(use_enable playlist)
		$(use_enable rss miner-rss)
		$(use_enable test functional-tests)
		$(use_enable test unit-tests)
		$(use_enable thunderbird miner-thunderbird)
		$(use_with thunderbird thunderbird-plugin-dir ${EPREFIX}/usr/$(get_libdir)/thunderbird/extensions)
		THUNDERBIRD=${S}/thunderbird-version.sh
		$(use_enable tiff libtiff)
		$(use_enable vorbis libvorbis)
		$(use_enable xml libxml2)
		$(use_enable xmp exempi)"
	#	$(use_enable strigi libstreamanalyzer)

	DOCS="AUTHORS ChangeLog NEWS README"

	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# Fix build failures with USE=strigi
	epatch "${FILESDIR}/${PN}-0.12.3-strigi.patch"

	# bug #426276, https://bugzilla.gnome.org/show_bug.cgi?id=675660
	epatch "${FILESDIR}/${PN}-0.14.2-icu-no-LC_ALL.patch"

	# Fix functional tests scripts
	find "${S}" -name "*.pyc" -delete
	python_convert_shebangs -r 2 tests utils examples

	# Don't run 'firefox --version' or 'thunderbird --version'; it results in
	# access violations on some setups (bug #385347, #385495).
	create_version_script "www-client/firefox" "Mozilla Firefox" firefox-version.sh
	create_version_script "mail-client/thunderbird" "Mozilla Thunderbird" thunderbird-version.sh

	# FIXME: report broken tests
	sed -e '/\/libtracker-miner\/tracker-password-provider\/setting/,+1 s:^\(.*\)$:/*\1*/:' \
		-e '/\/libtracker-miner\/tracker-password-provider\/getting/,+1 s:^\(.*\)$:/*\1*/:' \
		-i tests/libtracker-miner/tracker-password-provider-test.c || die

	gnome2_src_prepare
}

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	Xemake check XDG_DATA_HOME="${T}" XDG_CONFIG_HOME="${T}"
}

src_install() {
	gnome2_src_install

	# Manually symlink extensions for {firefox,thunderbird}-bin
	if use firefox-bookmarks; then
		dosym /usr/share/xul-ext/trackerfox \
			/usr/$(get_libdir)/firefox-bin/extensions/trackerfox@bustany.org
	fi

	if use thunderbird; then
		dosym /usr/share/xul-ext/trackerbird \
			/usr/$(get_libdir)/thunderbird-bin/extensions/trackerbird@bustany.org
	fi
}

create_version_script() {
	# Create script $3 that prints "$2 MAX(VERSION($1), VERSION($1-bin))"

	local v=$(best_version ${1})
	v=${v#${1}-}
	local vbin=$(best_version ${1}-bin)
	vbin=${vbin#${1}-bin-}

	if [[ -z ${v} ]]; then
		v=${vbin}
	else
		version_compare ${v} ${vbin}
		[[ $? -eq 1 ]] && v=${vbin}
	fi

	echo -e "#!/bin/sh\necho $2 $v" > "$3" || die
	chmod +x "$3" || die
}
