# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/scummvm-tools/scummvm-tools-1.7.0.ebuild,v 1.4 2014/10/18 14:34:39 ago Exp $

EAPI=5
WX_GTK_VER=2.8
inherit wxwidgets eutils flag-o-matic games

DESCRIPTION="utilities for the SCUMM game engine"
HOMEPAGE="http://scummvm.sourceforge.net/"
SRC_URI="mirror://sourceforge/scummvm/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86 ~x86-fbsd"
IUSE="flac iconv mad png vorbis"
RESTRICT="test" # some tests require external files

RDEPEND="png? ( media-libs/libpng:0 )
	mad? ( media-libs/libmad )
	flac? ( media-libs/flac )
	vorbis? ( media-libs/libvorbis )
	iconv? ( virtual/libiconv media-libs/freetype:2 )
	sys-libs/zlib
	>=dev-libs/boost-1.32
	x11-libs/wxGTK:2.8"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	rm -rf *.bat dists/win32

	sed -ri \
		-e '/^(CC|CXX)\b/d' \
		Makefile || die

	local boost_ver=$(best_version ">=dev-libs/boost-1.32")

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
	# Not an autoconf script
	./configure \
		--enable-verbose-build \
		--mandir=/usr/share/man \
		--prefix="${GAMES_PREFIX}" \
		--libdir="${GAMES_PREFIX}/lib" \
		$(use_enable flac) \
		$(use_enable iconv) \
		$(use_enable iconv freetype) \
		$(use_enable mad) \
		$(use_enable png) \
		$(use_enable vorbis) \
		|| die
}

src_install() {
	local f
	for f in $(find . -type f -perm +1 -print); do
		newgamesbin $f ${PN}-${f##*/} || die
	done
	dodoc README TODO
	prepgamesdirs
}
