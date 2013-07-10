# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/clementine/clementine-1.1.1.ebuild,v 1.10 2013/07/10 04:52:47 patrick Exp $

EAPI=5

LANGS=" af ar be bg bn br bs ca cs cy da de el en_CA en_GB eo es es_AR et eu fa fi fr ga gl he hi hr hu hy ia id is it ja ka kk ko lt lv mr ms nb nl oc pa pl pt pt_BR ro ru sk sl sr sr@latin sv te tr uk uz vi zh_CN zh_TW"

inherit cmake-utils flag-o-matic gnome2-utils virtualx

DESCRIPTION="A modern music player and library organizer based on Amarok 1.4 and Qt4"
HOMEPAGE="http://www.clementine-player.org/ http://code.google.com/p/clementine-player/"
SRC_URI="http://clementine-player.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="ayatana cdda +dbus debug googledrive ios ipod lastfm mms moodbar mtp projectm test +udev wiimote"
IUSE+="${LANGS// / linguas_}"

REQUIRED_USE="
	ios? ( ipod )
	udev? ( dbus )
	wiimote? ( dbus )
"

COMMON_DEPEND="
	>=dev-qt/qtgui-4.5:4[dbus(+)?]
	>=dev-qt/qtopengl-4.5:4
	>=dev-qt/qtsql-4.5:4[sqlite]
	dev-db/sqlite[fts3(+)]
	>=media-libs/taglib-1.7[mp4]
	>=dev-libs/glib-2.24.1-r1
	dev-libs/libxml2
	dev-libs/protobuf:=
	dev-libs/qjson
	media-libs/libechonest
	>=media-libs/chromaprint-0.6
	media-libs/gstreamer:0.10
	media-libs/gst-plugins-base:0.10
	virtual/glu
	virtual/opengl
	ayatana? ( dev-libs/libindicate-qt )
	cdda? ( dev-libs/libcdio )
	googledrive? ( >=media-libs/taglib-1.8[mp4] )
	ipod? (
		>=media-libs/libgpod-0.8.0[ios?]
		ios? (
			app-pda/libplist:=
			>=app-pda/libimobiledevice-1.0:=
			app-pda/usbmuxd
		)
	)
	lastfm? ( >=media-libs/liblastfm-1 )
	mtp? ( >=media-libs/libmtp-1.0.0 )
	moodbar? ( sci-libs/fftw:3.0 )
	projectm? ( media-libs/glew )
"
# now only presets are used, libprojectm is internal
# http://code.google.com/p/clementine-player/source/browse/#svn/trunk/3rdparty/libprojectm/patches
# r1966 "Compile with a static sqlite by default, since Qt 4.7 doesn't seem to expose the symbols we need to use FTS"
RDEPEND="${COMMON_DEPEND}
	dbus? ( udev? ( sys-fs/udisks:0 ) )
	mms? ( media-plugins/gst-plugins-libmms:0.10 )
	mtp? ( gnome-base/gvfs )
	projectm? ( >=media-libs/libprojectm-1.2.0 )
	media-plugins/gst-plugins-meta:0.10
	media-plugins/gst-plugins-gio:0.10
	media-plugins/gst-plugins-soup:0.10
	media-plugins/gst-plugins-taglib:0.10
"
DEPEND="${COMMON_DEPEND}
	>=dev-libs/boost-1.39
	virtual/pkgconfig
	sys-devel/gettext
	dev-qt/qttest:4
	dev-cpp/gmock
	googledrive? ( dev-cpp/sparsehash )
	test? ( gnome-base/gsettings-desktop-schemas )
"
DOCS="Changelog"

src_prepare() {
	# some tests fail or hang
	sed -i \
		-e '/add_test_file(translations_test.cpp/d' \
		tests/CMakeLists.txt || die
}

src_configure() {
	local langs x
	for x in ${LANGS}; do
		use linguas_${x} && langs+=" ${x}"
	done

	# spotify is not in portage
	local mycmakeargs=(
		-DBUILD_WERROR=OFF
		-DLINGUAS="${langs}"
		-DBUNDLE_PROJECTM_PRESETS=OFF
		$(cmake-utils_use cdda ENABLE_AUDIOCD)
		$(cmake-utils_use dbus ENABLE_DBUS)
		$(cmake-utils_use udev ENABLE_DEVICEKIT)
		$(cmake-utils_use ipod ENABLE_LIBGPOD)
		$(cmake-utils_use ios ENABLE_IMOBILEDEVICE)
		$(cmake-utils_use lastfm ENABLE_LIBLASTFM)
		$(cmake-utils_use mtp ENABLE_LIBMTP)
		$(cmake-utils_use moodbar ENABLE_MOODBAR)
		-DENABLE_GIO=ON
		$(cmake-utils_use wiimote ENABLE_WIIMOTEDEV)
		$(cmake-utils_use projectm ENABLE_VISUALISATIONS)
		$(cmake-utils_use ayatana ENABLE_SOUNDMENU)
		$(cmake-utils_use googledrive ENABLE_GOOGLE_DRIVE)
		-DENABLE_SPOTIFY=OFF
		-DENABLE_SPOTIFY_BLOB=OFF
		-DENABLE_SPOTIFY_DOWNLOADER=OFF
		-DENABLE_BREAKPAD=OFF
		-DSTATIC_SQLITE=OFF
		-DUSE_SYSTEM_GMOCK=ON
		)

	use !debug && append-cppflags -DQT_NO_DEBUG_OUTPUT

	cmake-utils_src_configure
}

src_test() {
	cd "${CMAKE_BUILD_DIR}" || die
	Xemake test
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
