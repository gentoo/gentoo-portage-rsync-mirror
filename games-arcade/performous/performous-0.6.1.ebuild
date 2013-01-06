# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/performous/performous-0.6.1.ebuild,v 1.10 2012/11/05 11:44:38 tupone Exp $

EAPI="3"

inherit flag-o-matic base cmake-utils games

MY_PN=Performous
MY_P=${MY_PN}-${PV}
SONGS_PN=ultrastar-songs

DESCRIPTION="SingStar GPL clone"
HOMEPAGE="http://sourceforge.net/projects/performous/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}-Source.tar.bz2
	songs? (
		mirror://sourceforge/${PN}/${SONGS_PN}-restricted-3.zip
		mirror://sourceforge/${PN}/${SONGS_PN}-jc-1.zip
		mirror://sourceforge/${PN}/${SONGS_PN}-libre-3.zip
		mirror://sourceforge/${PN}/${SONGS_PN}-shearer-1.zip
	)"

LICENSE="GPL-2
	songs? (
		CCPL-Attribution-ShareAlike-NonCommercial-2.5
		CCPL-Attribution-NonCommercial-NoDerivs-2.5
	)"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="songs tools"

RDEPEND="dev-cpp/glibmm
	dev-cpp/libxmlpp
	media-libs/portaudio
	>=dev-libs/boost-1.36
	dev-libs/glib
	dev-libs/libxml2
	gnome-base/librsvg
	media-gfx/imagemagick
	virtual/jpeg
	media-libs/libpng
	media-libs/libsdl
	virtual/ffmpeg
	virtual/opengl
	virtual/glu
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/pango"
DEPEND="${RDEPEND}
	media-libs/glew
	sys-apps/help2man"

S=${WORKDIR}/${MY_P}-Source

PATCHES=(
	"${FILESDIR}"/${P}-ffmpeg.patch
	"${FILESDIR}"/${P}-libav.patch
	"${FILESDIR}"/${P}-libpng.patch
	"${FILESDIR}"/${P}-gentoo.patch
	"${FILESDIR}"/${P}-linguas.patch
	"${FILESDIR}"/${P}-glib232.patch
	"${FILESDIR}"/${P}-boost150.patch
)

src_prepare() {
	base_src_prepare
	sed -i \
		-e "s:@GENTOO_BINDIR@:${GAMES_BINDIR}:" \
		game/CMakeLists.txt \
		|| die

	strip-linguas -u lang

	# how do I hate boost? Let me count the ways...
	local boost_ver=$(best_version ">=dev-libs/boost-1.36")

	boost_ver=${boost_ver/*boost-/}
	boost_ver=${boost_ver%.*}
	boost_ver=${boost_ver/./_}

	einfo "Using boost version ${boost_ver}"
	append-cxxflags \
		-I/usr/include/boost-${boost_ver}
	append-ldflags \
		-L/usr/$(get_libdir)/boost-${boost_ver}
	export BOOST_INCLUDEDIR="/usr/include/boost-${boost_ver}"
	export BOOST_LIBRARYDIR="/usr/$(get_libdir)/boost-${boost_ver}"
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable tools TOOLS)
		-DCMAKE_VERBOSE_MAKEFILE=TRUE
		-DSHARE_INSTALL="${GAMES_DATADIR}"/${PN}
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	if use songs ; then
		insinto "${GAMES_DATADIR}"/${PN}
		doins -r "${WORKDIR}/songs" || die
	fi
	dodoc docs/{Authors,DeveloperReadme,instruments,TODO}.txt
	prepgamesdirs
}
