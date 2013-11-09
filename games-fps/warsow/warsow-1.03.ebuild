# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/warsow/warsow-1.03.ebuild,v 1.1 2013/11/09 12:44:30 hasufell Exp $

EAPI=5
inherit eutils check-reqs gnome2-utils flag-o-matic games

BASE_DATA_PV=1.0
BASE_DATA_P=${PN}_${BASE_DATA_PV}_unified
DATA_PV=1.02
UPDATE_P=${PN}_${DATA_PV}_update
ENGINE_PV=${PV}
ENGINE_P=${PN}_${ENGINE_PV}_sdk

DESCRIPTION="Multiplayer FPS based on the QFusion engine (evolved from Quake 2)"
HOMEPAGE="http://www.warsow.net/"
SRC_URI="http://funpark.warsow-esport.net/~warsow/${BASE_DATA_PV}/${BASE_DATA_P}.tar.gz
	http://www.warsow.net:1337/~warsow/${PV}/${ENGINE_P}.tar.gz
	http://funpark.warsow-esport.net/~warsow/${PV}/${UPDATE_P}.zip
	mirror://gentoo/warsow.png"

# ZLIB: bundled angelscript
LICENSE="GPL-2 ZLIB warsow"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+angelscript debug dedicated irc openal server"

RDEPEND=">=dev-libs/libRocket-1.2.1_p20130110
	media-libs/freetype
	net-misc/curl
	sys-libs/zlib
	!dedicated? (
		media-libs/libpng:0
		media-libs/libsdl
		media-libs/libtheora
		media-libs/libvorbis
		x11-libs/libX11
		x11-libs/libXinerama
		x11-libs/libXrandr
		x11-libs/libXxf86dga
		x11-libs/libXxf86vm
		virtual/jpeg
		virtual/opengl
		openal? ( media-libs/openal )
	)"
DEPEND="${RDEPEND}
	app-arch/unzip
	x11-misc/makedepend
	!dedicated? (
		x11-proto/xineramaproto
		x11-proto/xf86dgaproto
		x11-proto/xf86vidmodeproto
	)
	openal? ( virtual/pkgconfig )"

S=${WORKDIR}/${ENGINE_P}/source
S_U=${WORKDIR}/${PN}_${BASE_DATA_PV}
S_UPDATE=${WORKDIR}/${UPDATE_P}

CHECKREQS_DISK_BUILD="1G"
CHECKREQS_DISK_USR="500M"

src_unpack() {
	unpack ${BASE_DATA_P}.tar.gz ${ENGINE_P}.tar.gz
	mkdir "${S_UPDATE}" || die
	cd "${S_UPDATE}" || die
	unpack ${UPDATE_P}.zip
}

src_prepare() {
	if [[ $(tc-getCC) =~ clang ]]; then
		einfo "disabling -ffast-math due to clang bug"
		einfo "http://llvm.org/bugs/show_bug.cgi?id=13745"
		append-cflags -fno-fast-math
		append-cxxflags -fno-fast-math
	fi

	sed -i \
		-e "/fs_basepath =/ s:\.:${GAMES_DATADIR}/${PN}:" \
		qcommon/files.c \
		|| die "sed files.c failed"

	sed -i \
		-e "s:q_jpeg_mem_src:_&:" \
		ref_gl/r_image.c || die "sed r_image.c failed"

	rm -r "${S_U}"/docs/old* || die

	# edos2unix breaks whitespace files
	einfo "removing dos line breaks"
	find . -type f -exec sed -i 's/\r$//' '{}' + || die

	cd "${S}"/.. || die
	epatch "${FILESDIR}"/${PF}-build.patch \
		"${FILESDIR}"/${P}-pic.patch \
		"${FILESDIR}"/{01..03}-${P}-clang.patch
	epatch_user
}

src_compile() {
	yesno() { use ${1} && echo YES || echo NO ; }

	use angelscript &&
		emake -C ../libsrcs/angelscript/angelSVN/sdk/angelscript/projects/gnuc

	local arch
	if use amd64 ; then
		arch=x86_64
	elif use x86 ; then
		arch=i386
	fi

	local myconf
	if use dedicated ; then
		myconf=(
			BUILD_CLIENT=NO
			BUILD_IRC=NO
			BUILD_SND_OPENAL=NO
			BUILD_SND_QF=NO
			BUILD_CIN=NO
			BUILD_SERVER=YES
			BUILD_TV_SERVER=YES
		)
	else
		myconf=(
			BUILD_CLIENT=YES
			BUILD_IRC=$(yesno irc)
			BUILD_SND_OPENAL=$(yesno openal)
			BUILD_SND_QF=YES
			BUILD_CIN=YES
			BUILD_SERVER=$(yesno server)
			BUILD_TV_SERVER=$(yesno server)
		)
	fi

	emake \
		V=YES \
		SYSTEM_LIBS=YES \
		BASE_ARCH=${arch} \
		BINDIR=lib \
		BUILD_ANGELWRAP=$(yesno angelscript) \
		DEBUG_BUILD=$(yesno debug) \
		${myconf[@]}
}

src_install() {
	cd lib

	if ! use dedicated ; then
		newgamesbin ${PN}.* ${PN}
		doicon -s 48 "${DISTDIR}"/${PN}.png
		make_desktop_entry ${PN} Warsow
	fi

	if use dedicated || use server ; then
		newgamesbin wsw_server.* ${PN}-ded
		newgamesbin wswtv_server.* ${PN}-tv
	fi

	exeinto "$(games_get_libdir)"/${PN}
	doexe */*.so

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r "${S_U}"/basewsw
	doins -r "${S_UPDATE}"/basewsw

	local so
	for so in basewsw/*.so ; do
		dosym "$(games_get_libdir)"/${PN}/${so##*/} \
			"${GAMES_DATADIR}"/${PN}/${so}
	done

	if [[ -e libs ]] ; then
		dodir "${GAMES_DATADIR}"/${PN}/libs
		for so in libs/*.so ; do
			dosym "$(games_get_libdir)"/${PN}/${so##*/} \
				"${GAMES_DATADIR}"/${PN}/${so}
		done
	fi

	dodoc "${S_U}"/docs/*
	dodoc "${S_UPDATE}"/docs/*
	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
