# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/warsow/warsow-1.02-r1.ebuild,v 1.2 2013/01/19 13:44:28 hasufell Exp $

EAPI=4
inherit eutils check-reqs gnome2-utils games

MY_P=${PN}_${PV}
DESCRIPTION="Multiplayer FPS based on the QFusion engine (evolved from Quake 2)"
HOMEPAGE="http://www.warsow.net/"
SRC_URI="http://funpark.warsow-esport.net/~${PN}/1.0/${PN}_1.0_unified.tar.gz
	http://funpark.warsow-esport.net/~${PN}/${PV}/${MY_P}_sdk.tar.gz
	http://funpark.warsow-esport.net/~${PN}/${PV}/${MY_P}_update.zip
	mirror://gentoo/${PN}.png"

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

S=${WORKDIR}/${MY_P}_sdk/source
S_U=${WORKDIR}/${PN}_1.0
S_UPDATE=${WORKDIR}/${MY_P}_update

CHECKREQS_DISK_BUILD="1G"
CHECKREQS_DISK_USR="500M"

src_unpack() {
	unpack ${PN}_1.0_unified.tar.gz ${MY_P}_sdk.tar.gz
	mkdir "${S_UPDATE}" || die
	cd "${S_UPDATE}" || die
	unpack ${MY_P}_update.zip
}

src_prepare() {
	sed -i \
		-e "/fs_basepath =/ s:\.:${GAMES_DATADIR}/${PN}:" \
		qcommon/files.c \
		|| die "sed files.c failed"

	sed -i \
		-e "s:q_jpeg_mem_src:_&:" \
		ref_gl/r_image.c || die "sed r_image.c failed"

	rm -r "${S_U}"/docs/old* || die

	cd "${WORKDIR}"/${MY_P}_sdk || die
	epatch "${FILESDIR}"/${P}-build.patch \
		"${FILESDIR}"/${P}-pic.patch
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
