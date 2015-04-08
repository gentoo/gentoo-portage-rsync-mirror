# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/sdlmametools/sdlmametools-0.148_p1.ebuild,v 1.3 2013/11/22 22:18:49 hasufell Exp $

EAPI=5
PYTHON_COMPAT=( python2_6 python2_7 )
inherit eutils flag-o-matic python-any-r1 games

MY_PV=${PV/.}
MY_P=${PN%tools}${MY_PV}
MY_P=${MY_P%%_p*}

# patches
SRC_URI="$(for PATCH_VER in $(seq 1 ${PV##*_p}) ; do echo "http://dev.gentoo.org/~hasufell/distfiles/${MY_P}u${PATCH_VER}_diff.zip"; done)"

DESCRIPTION="Set of development tools shared between sdlmame and sdlmess"
HOMEPAGE="http://mamedev.org/"
# Upstream doesn't allow fetching with unknown User-Agent such as wget
SRC_URI="$SRC_URI http://dev.gentoo.org/~hasufell/distfiles/${MY_P/sdl}s.zip"

LICENSE="XMAME"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="X debug"
REQUIRED_USE="debug? ( X )"

RDEPEND="
	dev-libs/expat
	media-libs/flac
	>=media-libs/libsdl-1.2.10
	media-libs/sdl-ttf
	sys-libs/zlib
	X? (
		x11-libs/libX11
	)"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	app-arch/unzip
	virtual/pkgconfig
	X? ( x11-proto/xineramaproto )"

S=${WORKDIR}

# Function to disable a makefile option
disable_feature() {
	sed -i \
		-e "/$1.*=/s:^:# :" \
		"${S}"/makefile \
		|| die "sed failed"
}

# Function to enable a makefile option
enable_feature() {
	sed -i \
		-e "/^#.*$1.*=/s:^#::"  \
		"${S}"/${2:-makefile} \
		|| die "sed failed"
}

pkg_setup() {
	games_pkg_setup
	python-any-r1_pkg_setup
}

src_unpack() {
	default
	unpack ./mame.zip
	rm -f mame.zip
}

src_prepare() {
	if [[ $PV == *_p* ]] ; then
		edos2unix $(find $(grep +++ *diff | awk '{ print $2 }' | sort -u) 2>/dev/null) *diff
		einfo "Patching release with source updates"
		epatch ${MY_PV%%_p*}*.diff
	fi
	edos2unix src/osd/sdl/osdsdl.h

	epatch \
		"${FILESDIR}"/${P}-makefile.patch \
		"${FILESDIR}"/${P}-no-opengl.patch

	# Don't compile zlib and expat
	einfo "Disabling embedded libraries: expat, flac, jpeg, zlib"
	disable_feature BUILD_EXPAT
	disable_feature BUILD_FLAC
	disable_feature BUILD_JPEG
	disable_feature BUILD_ZLIB

	if use amd64; then
		einfo "Enabling 64-bit support"
		enable_feature PTR64
	fi

	if use ppc; then
		einfo "Enabling PPC support"
		enable_feature BIGENDIAN
	fi

	if use debug; then
		einfo "Enabling debug support"
		enable_feature DEBUG
	fi

	if ! use X ; then
		einfo "Disabling X support"
		enable_feature NO_X11 src/osd/sdl/sdl.mak
	fi
}

src_compile() {
	emake \
		NO_DEBUGGER=$(usex debug "0" "1") tools
}

src_install() {
	for i in chdman jedutil ldresample ldverify regrep romcmp testkeys ; do
		newgamesbin ${i} sdlmame-${i}
		nonfatal newman src/osd/sdl/man/${i}.1 sdlmame-${i}.1
	done

	prepgamesdirs
}
