# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/worldofpadman/worldofpadman-1.2-r1.ebuild,v 1.5 2012/02/05 06:08:25 vapier Exp $

EAPI=2
inherit eutils unpacker games

MY_P=wop-engine-${PV}
DESCRIPTION="A cartoon style multiplayer first-person shooter"
HOMEPAGE="http://worldofpadman.com/"
SRC_URI="ftp://kickchat.com/wop/${MY_P}.tar.bz2
	ftp://kickchat.com/wop/wop_patch_${PV/./_}.run
	http://thilo.kickchat.com/download/${PN}.run
	maps? ( http://thilo.kickchat.com/download/wop_padpack.zip )"

LICENSE="GPL-2 worldofpadman"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="dedicated maps openal opengl"

UIDEPEND="virtual/opengl
	media-libs/libsdl[X,joystick,opengl,video]
	media-libs/libogg
	media-libs/libvorbis
	net-misc/curl
	openal? ( media-libs/openal )"
RDEPEND="opengl? ( ${UIDEPEND} )
	!opengl? ( !dedicated? ( ${UIDEPEND} ) )"
DEPEND="${RDEPEND}
	maps? ( app-arch/unzip )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${MY_P}.tar.bz2
	unpack_makeself ${PN}.run
	unpack_makeself wop_patch_1_2.run
	unpack ./readme.tar
	mkdir wop
	cd wop
	unpack ./../wop-data.tar
	unpack ./../wop-data-${PV}.tar
	use dedicated && unpack ./../extras.tar || rm -f *.cfg
	use maps && unpack wop_padpack.zip
}

src_prepare() {
	sed -i \
		-e '/ LDFLAGS=/s:=:+=:' \
		Makefile \
		|| die "sed failed"
}

src_compile() {
	local arch

	if use amd64 ; then
		arch=x86_64
	elif use x86 ; then
		arch=i386
	fi

	emake \
		ARCH=${arch} \
		BUILD_CLIENT=$(use opengl || ! use dedicated && echo 1 || echo 0) \
		BUILD_SERVER=$(use dedicated && echo 1 || echo 0) \
		DEFAULT_BASEDIR="${GAMES_DATADIR}"/${PN} \
		OPTIMIZE= \
		USE_CURL_DLOPEN=0 \
		USE_LOCAL_HEADERS=0 \
		USE_OPENAL=$(use openal && echo 1 || echo 0) \
		USE_OPENAL_DLOPEN=0 \
		|| die "emake failed"
}

src_install() {
	cd build/release-*
	if use opengl || ! use dedicated ; then
		newgamesbin wop-engine.* ${PN} || die "newgamesbin ${PN} failed"
		newicon "${WORKDIR}"/wop.png ${PN}.png
		make_desktop_entry ${PN} "World of Padman"
	fi
	if use dedicated ; then
		newgamesbin wopded.* ${PN}-ded || die "newgamesbin ${PN}-ded failed"
	fi
	cd "${WORKDIR}"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r wop || die "doins failed"
	dohtml -r readme readme.html
	dodoc wop_patch_*.txt
	prepgamesdirs
}
