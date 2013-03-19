# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/wesnoth/wesnoth-1.10.6.ebuild,v 1.1 2013/03/19 17:04:35 mr_bones_ Exp $

EAPI=2
inherit cmake-utils eutils multilib toolchain-funcs flag-o-matic games

DESCRIPTION="Battle for Wesnoth - A fantasy turn-based strategy game"
HOMEPAGE="http://www.wesnoth.org/"
SRC_URI="mirror://sourceforge/wesnoth/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="dbus dedicated doc nls server"

RDEPEND=">=media-libs/libsdl-1.2.7[joystick,video,X]
	media-libs/sdl-net
	>=media-libs/sdl-ttf-2.0.8
	>=media-libs/sdl-mixer-1.2[vorbis]
	>=media-libs/sdl-image-1.2[jpeg,png]
	!dedicated? (
		dbus? ( sys-apps/dbus )
	)
	>=dev-libs/boost-1.36
	sys-libs/zlib
	x11-libs/pango
	dev-lang/lua
	media-libs/fontconfig
	virtual/libintl"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext"

src_prepare() {
	if use dedicated || use server ; then
		sed \
			-e "s:GAMES_BINDIR:${GAMES_BINDIR}:" \
			-e "s:GAMES_STATEDIR:${GAMES_STATEDIR}:" \
			-e "s/GAMES_USER_DED/${GAMES_USER_DED}/" \
			-e "s/GAMES_GROUP/${GAMES_GROUP}/" "${FILESDIR}"/wesnothd.rc \
			> "${T}"/wesnothd \
			|| die "sed failed"
	fi
	if ! use doc ; then
		sed -i \
			-e '/manual/d' \
			doc/CMakeLists.txt \
			|| die "sed failed"
	fi
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
	filter-flags -ftracer -fomit-frame-pointer
	if [[ $(gcc-major-version) -eq 3 ]] ; then
		filter-flags -fstack-protector
		append-flags -fno-stack-protector
	fi
	if use dedicated || use server ; then
		mycmakeargs=(
			"-DENABLE_CAMPAIGN_SERVER=TRUE"
			"-DENABLE_SERVER=TRUE"
			"-DSERVER_UID=${GAMES_USER_DED}"
			"-DSERVER_GID=${GAMES_GROUP}"
			"-DFIFO_DIR=${GAMES_STATEDIR}/run/wesnothd"
			)
	else
		mycmakeargs=(
			"-DENABLE_CAMPAIGN_SERVER=FALSE"
			"-DENABLE_SERVER=FALSE"
			)
	fi
	mycmakeargs+=(
		$(cmake-utils_use_enable !dedicated GAME)
		$(cmake-utils_use_enable !dedicated ENABLE_DESKTOP_ENTRY)
		$(cmake-utils_use_enable nls NLS)
		$(cmake-utils_use_enable dbus NOTIFICATIONS)
		"-DCMAKE_VERBOSE_MAKEFILE=TRUE"
		"-DENABLE_FRIBIDI=FALSE"
		"-DENABLE_STRICT_COMPILATION=FALSE"
		"-DCMAKE_INSTALL_PREFIX=${GAMES_PREFIX}"
		"-DDATAROOTDIR=${GAMES_DATADIR}"
		"-DBINDIR=${GAMES_BINDIR}"
		"-DICONDIR=/usr/share/pixmaps"
		"-DDESKTOPDIR=/usr/share/applications"
		"-DMANDIR=/usr/share/man"
		"-DDOCDIR=/usr/share/doc/${PF}"
		)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	DOCS="README changelog players_changelog" cmake-utils_src_install
	if use dedicated || use server; then
		keepdir "${GAMES_STATEDIR}/run/wesnothd"
		doinitd "${T}"/wesnothd || die "doinitd failed"
	fi
	prepgamesdirs
}
