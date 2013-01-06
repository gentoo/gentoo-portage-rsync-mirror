# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/pingus/pingus-0.7.6.ebuild,v 1.9 2012/12/08 07:32:00 mr_bones_ Exp $

EAPI=2
inherit eutils flag-o-matic scons-utils toolchain-funcs games

DESCRIPTION="free Lemmings clone"
HOMEPAGE="http://pingus.seul.org/"
SRC_URI="http://pingus.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="opengl music"

DEPEND="media-libs/libsdl[joystick,opengl?,video]
	media-libs/sdl-image[png]
	media-libs/sdl-mixer
	music? ( media-libs/sdl-mixer[mod] )
	opengl? ( virtual/opengl )
	media-libs/libpng
	dev-libs/boost"

src_prepare() {
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

	strip-flags
	epatch \
		"${FILESDIR}"/${P}-noopengl.patch \
		"${FILESDIR}"/${P}-gcc47.patch
}

src_compile() {
	escons \
		CXX="$(tc-getCXX)" \
		CCFLAGS="${CXXFLAGS}" \
		LINKFLAGS="${LDFLAGS}" \
		$(use_scons opengl with_opengl) \
		|| die
}

src_install() {
	emake install-exec install-data \
		DESTDIR="${D}" \
		PREFIX="/usr" \
		DATADIR="${GAMES_DATADIR}/${PN}" \
		BINDIR="${GAMES_BINDIR}" \
		|| die
	doman doc/man/pingus.6
	doicon data/images/icons/pingus.svg
	make_desktop_entry ${PN} Pingus
	dodoc AUTHORS NEWS README TODO
	prepgamesdirs
}
