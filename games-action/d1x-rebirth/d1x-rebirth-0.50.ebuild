# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/d1x-rebirth/d1x-rebirth-0.50.ebuild,v 1.5 2014/04/04 05:56:31 ulm Exp $

inherit eutils games

# DV is the Descent version. Used because the d2x-rebirth ebuild is similar.
DV="1"
DATE="20061025"
DVX=d${DV}x
FILE_START="${PN}_v${PV}-src-${DATE}"
SRC_STEM="http://www.dxx-rebirth.de/download/dxx"

DESCRIPTION="Descent Rebirth - enhanced Descent 1 client"
HOMEPAGE="http://www.dxx-rebirth.de/"
SRC_URI="${SRC_STEM}/oss/src/${FILE_START}.tar.gz
	${SRC_STEM}/res/dxx-rebirth_icons.zip
	${SRC_STEM}/res/${PN}_hires-briefings.zip
	${SRC_STEM}/res/${PN}_hires-fonts.zip"

# Licence info at bug #117344.
# All 3 licences apply.
LICENSE="D1X
	GPL-2
	public-domain"
SLOT="0"
# Should work on amd64 also
KEYWORDS="~amd64 x86"
IUSE="awe32 debug demo mpu401 opengl mixer"

QA_EXECSTACK="${GAMES_BINDIR:1}/${PN}"

UIRDEPEND="media-libs/alsa-lib
	>=media-libs/libsdl-1.2.9
	>=media-libs/sdl-image-1.2.3-r1
	mixer? ( media-libs/sdl-mixer )
	>=dev-games/physfs-1.0.1
	opengl? (
		virtual/glu
		virtual/opengl )
	x11-libs/libX11"
UIDEPEND="x11-proto/xf86dgaproto
	x11-proto/xf86vidmodeproto
	x11-proto/xproto"
# There is no ebuild for descent1-data
RDEPEND="${UIRDEPEND}
	demo? ( games-action/descent1-demodata )"
DEPEND="${UIRDEPEND}
	${UIDEPEND}
	dev-util/scons
	app-arch/unzip"

S=${WORKDIR}/${PN}
dir=${GAMES_DATADIR}/${DVX}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# "sdl_only=1" does not compile otherwise:
	# arch/sdl/clipboard.o: In function `getClipboardText':
	# clipboard.c:(.text+0x89): undefined reference to `XGetSelectionOwner'
	sed -i \
		-e "s:'SDL':'SDL', 'X11':" \
		-e "s:-O2:${CXXFLAGS}:" \
		SConstruct || die "sed SConstruct failed"

	# Midi music - awe32 for most SoundBlaster cards
	if use awe32 ; then
		sed -i \
			-e "s://#define WANT_AWE32 1:#define WANT_AWE32 1:" \
			arch/linux/hmiplay.c || die "sed awe32 failed"
	elif use mpu401 ; then
		sed -i \
			-e "s://#define WANT_MPU401 1:#define WANT_MPU401 1:" \
			arch/linux/hmiplay.c || die "sed mpu401 failed"
	fi
}

src_compile() {
	local opts
	use debug && opts="${opts} debug=1"
	use mixer && opts="${opts} sdlmixer=1"
	use x86 || opts="${opts} no_asm=1"
	use opengl || opts="${opts} sdl_only=1"
	use demo && opts="${opts} shareware=1"

	# From "scons -h"
	# sharepath must end with a slash.
	scons \
		${opts} \
		sharepath="${dir}/" \
		|| die "scons failed"
}

src_install() {
	# Reasonable set of default options.
	# Don't bother with ${DVX}.ini file.
	local params="-gl_trilinear -gl_anisotropy 8.0 -gl_16bpp -gl_16bittextures -gl_reticle 2 -fullscreen -menu_gameres -nomovies -nocdrom"

	local exe=${PN}-sdl
	use opengl && exe=${PN}-gl
	newgamesbin ${exe} ${PN} || die "newgamesbin ${exe} failed"
	games_make_wrapper ${PN}-common "${PN} ${params}"
	doicon "${WORKDIR}/${PN}.xpm"
	make_desktop_entry ${PN}-common "Descent ${DV} Rebirth" "${PN}"

	insinto "${dir}"
	doins "${WORKDIR}"/*.{pcx,fnt} || die

	dodoc *.txt

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	if use demo ; then
		elog "${PN} has been compiled specifically for the demo data."
	else
		elog "Place the DOS data files in ${dir}"
		ewarn "Re-emerge with the 'demo' USE flag if this error is shown:"
		ewarn "   Error: Not enough strings in text file"
	fi
	elog "To play the game with common options, run:  ${PN}-common"
	echo
}
