# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/d2x-rebirth/d2x-rebirth-0.50.ebuild,v 1.6 2014/04/04 05:57:19 ulm Exp $

EAPI=2
inherit autotools eutils games

# DV is the Descent version. Used because the d1x-rebirth ebuild is similar.
DV="2"
DATE="20061025"
DVX=d${DV}x
FILE_START="${PN}_v${PV}-src-${DATE}"
SRC_STEM="http://www.dxx-rebirth.de/download/dxx"

DESCRIPTION="Descent Rebirth - enhanced Descent 2 client"
HOMEPAGE="http://www.dxx-rebirth.de/"
SRC_URI="${SRC_STEM}/oss/src/${FILE_START}.tar.gz
	${SRC_STEM}/res/dxx-rebirth_icons.zip"
# These only apply to Descent 1
#	${SRC_STEM}/res/d1x-rebirth_hires-briefings.zip
#	${SRC_STEM}/res/d1x-rebirth_hires-fonts.zip

# Licence info at bug #117344.
# All 3 licences apply.
LICENSE="D1X
	GPL-2
	public-domain"
SLOT="0"
# Should work on amd64 also
KEYWORDS="~x86"
IUSE="awe32 debug mpu401"

QA_EXECSTACK="${GAMES_BINDIR:1}/${PN}"

UIRDEPEND="media-libs/alsa-lib
	media-libs/libpng
	>=media-libs/libsdl-1.2.9
	>=media-libs/sdl-image-1.2.3-r1
	>=dev-games/physfs-1.0.1[hog,zip]
	virtual/glu
	virtual/opengl
	x11-libs/libX11
	x11-libs/libXext"
UIDEPEND="x11-proto/xf86dgaproto
	x11-proto/xf86vidmodeproto
	x11-proto/xproto"
# This game does not work with the demo data
RDEPEND="${UIRDEPEND}
	games-action/descent2-data"
DEPEND="${UIRDEPEND}
	${UIDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${PN}
dir=${GAMES_DATADIR}/${DVX}

src_prepare() {
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
	eautoreconf
}

src_configure() {
	# Configure options are specified in dxx-compile.txt
	local opts
	use x86 || opts="${opts} --disable-fastfileio"
	if use debug ; then
		opts="${opts} --enable-debug"
	else
		opts="${opts} --disable-debug --enable-release"
	fi

	egamesconf \
		${opts} \
		--with-sharepath="${dir}" \
		--with-opengl
}

src_compile() {
	emake -j1 || die
}

src_install() {
	local icon="${PN}.xpm"
	# Reasonable set of default options.
	# Don't bother with ${DVX}.ini file.
	local params="-gl_trilinear -gl_anisotropy 8.0 -gl_16bpp -gl_16bittextures -gl_reticle 2 -fullscreen -menu_gameres -nomovies -nocdrom"

	newgamesbin ${PN}-gl ${PN} || die "newgamesbin failed"
	games_make_wrapper ${PN}-common "${PN} ${params}"
	doicon "${WORKDIR}/${icon}"
	make_desktop_entry ${PN}-common "Descent ${DV} Rebirth" "${icon}"

	dodoc AUTHORS ChangeLog dxx-changelog dxx-readme.txt NEWS \
		README "${WORKDIR}"/*.txt

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	elog "To play the game with common options, run:  ${PN}-common"
	echo
}
