# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/worldofpadman/worldofpadman-1.6.ebuild,v 1.4 2012/05/21 20:08:47 ssuominen Exp $

EAPI=3

inherit eutils base games

DESCRIPTION="A cartoon style multiplayer first-person shooter"
HOMEPAGE="http://worldofpadman.com/"
SRC_URI="mirror://sourceforge/${PN}/wop-1.5-unified.zip
	mirror://sourceforge/${PN}/wop-1.5.x-to-1.6-patch-unified.zip"

LICENSE="GPL-2 worldofpadman"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+curl dedicated maps +openal +theora +vorbis"

RDEPEND="sys-libs/zlib
	!dedicated? (
		media-libs/speex
		virtual/jpeg
		media-libs/libsdl
		virtual/opengl
		openal? ( media-libs/openal )
		curl? ( net-misc/curl )
		vorbis? ( media-libs/libvorbis )
		theora? (
			media-libs/libtheora
			media-libs/libogg
		)
	)"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}"/${P}_svn2178-src

PATCHES=( "${FILESDIR}"/${P}-gentoo.patch )

src_unpack() {
	unpack ${A}
	unzip XTRAS/"editing files"/${P}-src.zip
}

src_compile() {
	local arch

	if use amd64 ; then
		arch=x86_64
	elif use x86 ; then
		arch=i386
	fi

	emake \
		V=1 \
		ARCH=${arch} \
		BUILD_CLIENT=$(use dedicated && echo 0) \
		DEFAULT_BASEDIR="${GAMES_DATADIR}"/${PN} \
		OPTIMIZE= \
		USE_CURL=$(use curl && echo 1 || echo 0) \
		USE_CURL_DLOPEN=0 \
		USE_OPENAL=$(use openal && echo 1 || echo 0) \
		USE_OPENAL_DLOPEN=0 \
		USE_CODEC_VORBIS=$(use vorbis && echo 1 || echo 0) \
		USE_CIN_THEORA=$(use theora && echo 1 || echo 0) \
		USE_RENDERER_DLOPEN=0 \
		USE_INTERNAL_ZLIB=0 \
		USE_INTERNAL_JPEG=0 \
		USE_INTERNAL_SPEEX=0 \
		|| die "died running emake"
}

src_install() {
	newgamesbin build/release-*/wopded.* ${PN}-ded \
		|| die "newgamesbin ${PN}-ded failed"
	if ! use dedicated ; then
		newgamesbin build/release-*/wop.* ${PN} \
			|| die "newgamesbin ${PN} failed"
		newicon misc/quake3.png ${PN}.png || die "newicon failed"
		make_desktop_entry ${PN} "World of Padman"
	fi
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r ../wop || die "doins failed"

	dodoc id-readme.txt \
		IOQ3-README \
		voip-readme.txt \
		../XTRAS/changelog.txt \
		../XTRAS/sounds_readme.txt \
		|| die "dodoc failed"
	dohtml -r ../XTRAS/readme{,.html} || die "dohtml failed"
	prepgamesdirs
}
