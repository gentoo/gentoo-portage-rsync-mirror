# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/eduke32/eduke32-20130201.3453.ebuild,v 1.1 2013/02/02 18:36:55 hasufell Exp $

# TODO/FIXME:
# lunatic broken
# lunatic? ( >=dev-lang/luajit-2.0.0_beta10:2 )
# $(usex lunatic "LUNATIC=1" "LUNATIC=0")
#
# extras? ( games-fps/${PN}-extras )
#
# clang does not build

EAPI=5

inherit eutils gnome2-utils games

MY_PV=${PV%.*}
MY_BUILD=${PV#*.}

DESCRIPTION="Port of Duke Nukem 3D for SDL"
HOMEPAGE="http://www.eduke32.com/ http://hrp.duke4.net/"
SRC_URI="http://dukeworld.duke4.net/eduke32/synthesis/${MY_PV}-${MY_BUILD}/${PN}_src_${MY_PV}-${MY_BUILD}.tar.bz2
	http://dev.gentoo.org/~hasufell/distfiles/eduke32-icons.tar"

LICENSE="GPL-2 BUILDLIC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cdinstall debug demo +opengl +png +server tools +vpx"
REQUIRED_USE="vpx? ( opengl )"

RDEPEND="media-libs/flac
	media-libs/libogg
	media-libs/libsdl[X,joystick,opengl?,video]
	media-libs/libvorbis
	media-libs/sdl-mixer[timidity]
	sys-libs/zlib
	x11-libs/gtk+:2
	opengl? ( virtual/glu
		virtual/opengl )
	png? ( media-libs/libpng:0
		sys-libs/zlib )
	vpx? ( media-libs/libvpx )"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"
PDEPEND="cdinstall? ( games-fps/duke3d-data )
	demo? ( games-fps/duke3d-demodata )"

S=${WORKDIR}/${PN}_${MY_PV}-${MY_BUILD}

src_prepare() {
	epatch "${FILESDIR}"/${P}-QA.patch

	# Point eduke32 to data files in shared duke3d folder.
	# Multiple search paths can be defined, so that with the default configuration as of
	# the 20130128 release, this adds /usr/share/games/duke3d in ADDITION to
	# /usr/share/games/eduke32 so that eduke32 and duke3d's base data can be kept separate.
	# also redirect log file so it's not always written in $PWD
	sed -i \
		-e "s;/usr/local/share/games/${PN};${GAMES_DATADIR}/duke3d;" \
		-e "s;mapster32.log;${GAMES_LOGDIR}/mapster32.log;" \
		source/astub.c || die "sed astub.c path update failed"
	sed -i \
		-e "s;/usr/local/share/games/${PN};${GAMES_DATADIR}/duke3d;" \
		-e "s;${PN}.log;${GAMES_LOGDIR}/${PN}.log;" \
		source/game.c || die "sed game.c path update failed"
}

src_compile() {
	local MY_OPTS=(
		ARCH=
		LTO=0
		PRETTY_OUTPUT=0
		RELEASE=1
		LUNATIC=0
		STRIP=touch
		LINKED_GTK=1
		CPLUSPLUS=0
		$(usex debug "DEBUGANYWAY=1" "DEBUGANYWAY=0")
		$(usex x86 "NOASM=0" "NOASM=1")
		$(usex server "NETCODE=1" "NETCODE=0")
		$(usex opengl "USE_OPENGL=1 POLYMER=1" "USE_OPENGL=0 POLYMER=0")
		$(usex png "USE_LIBPNG=1" "USE_LIBPNG=0")
		$(usex vpx "USE_LIBVPX=1" "USE_LIBVPX=0")
	)

	emake ${MY_OPTS[@]}

	if use tools; then
		emake -C build ${MY_OPTS[@]}
	fi
}

src_install() {
	dogamesbin ${PN} mapster32

	insinto "${GAMES_DATADIR}/${PN}"
	doins package/{SEHELP.HLP,STHELP.HLP,m32help.hlp,names.h,tiles.cfg}
	doins -r package/samples

	local i
	for i in 16 32 128 256 ; do
		newicon -s ${i} "${WORKDIR}"/${PN}_${i}x${i}x32.png ${PN}.png
		newicon -s ${i} "${WORKDIR}"/mapster32_${i}x${i}x32.png mapster32.png
	done

	make_desktop_entry ${PN} EDuke32 ${PN}
	make_desktop_entry mapster32 Mapster32 mapster32

	if use tools; then
		dobin build/{arttool,bsuite,cacheinfo,generateicon,givedepth,kextract,kgroup,kmd2tool,md2tool,mkpalette,transpal,unpackssi,wad2art,wad2map}
		dodoc build/doc/*.txt
	fi

	dodoc build/buildlic.txt

	dodir "${GAMES_LOGDIR}"

	prepgamesdirs

}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst
	gnome2_icon_cache_update

	use cdinstall || use demo || {
		elog "Note: You must also install the game data files, either manually or with"
		elog "games-fps/duke3d-demodata or games-fps/duke3d-data before playing."
	}

	einfo
	elog "${PN} reads data files from ${GAMES_DATADIR}/duke3d"
	einfo

	[[ -e ${ROOT}/${GAMES_LOGDIR} ]] || mkdir -p "${ROOT}/${GAMES_LOGDIR}"
	touch "${ROOT}/${GAMES_LOGDIR}"/${PN}.log
	touch "${ROOT}/${GAMES_LOGDIR}"/mapster32.log
	chown ${GAMES_USER}:${GAMES_GROUP} "${ROOT}/${GAMES_LOGDIR}"/${PN}.log
	chown ${GAMES_USER}:${GAMES_GROUP} "${ROOT}/${GAMES_LOGDIR}"/mapster32.log
	chmod g+w "${ROOT}/${GAMES_LOGDIR}"/${PN}.log
	chmod g+w "${ROOT}/${GAMES_LOGDIR}"/mapster32.log
}

pkg_postrm() {
	gnome2_icon_cache_update
}
