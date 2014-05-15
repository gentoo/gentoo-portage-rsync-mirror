# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gambatte/gambatte-0.5.0_p20130601.ebuild,v 1.2 2014/05/15 16:35:38 ulm Exp $

EAPI=5

inherit scons-utils qt4-r2 games

DESCRIPTION="An accuracy-focused Gameboy / Gameboy Color emulator"
HOMEPAGE="http://sourceforge.net/projects/gambatte"
SRC_URI="mirror://sourceforge/gambatte/gambatte_src-r537.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt4 +sdl"
REQUIRED_USE="|| ( qt4 sdl )"

RDEPEND="
	sys-libs/zlib
	qt4? (
		dev-qt/qtcore:4
		dev-qt/qtgui:4
		dev-qt/qtopengl:4
		media-libs/alsa-lib
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXrandr
		x11-libs/libXv
	)
	sdl? ( media-libs/libsdl[X,sound,joystick,video] )"
DEPEND="${RDEPEND}
	app-arch/gzip"

S=${WORKDIR}/${PN}_src-r537

fix_scons() {
	local i
	for i; do
		cat >> $i << END
import os
import SCons.Util

if os.environ.has_key('AR'):
	env['AR'] = os.environ['AR']
if os.environ.has_key('RANLIB'):
	env['RANLIB'] = os.environ['RANLIB']
if os.environ.has_key('CC'):
	env['CC'] = os.environ['CC']
if os.environ.has_key('CFLAGS'):
	env['CCFLAGS'] += SCons.Util.CLVar(os.environ['CFLAGS'])
if os.environ.has_key('CXX'):
	env['CXX'] = os.environ['CXX']
if os.environ.has_key('CXXFLAGS'):
	env['CXXFLAGS'] += SCons.Util.CLVar(os.environ['CXXFLAGS'])
if os.environ.has_key('CPPFLAGS'):
	env['CCFLAGS'] += SCons.Util.CLVar(os.environ['CPPFLAGS'])
if os.environ.has_key('LDFLAGS'):
	env['LINKFLAGS'] += SCons.Util.CLVar(os.environ['LDFLAGS'])
END
	done
}

src_prepare() {
	# Fix zlib/minizip build error
	sed -i \
		-e '1i#define OF(x) x' \
		libgambatte/src/file/unzip/{unzip,ioapi}.h \
		|| die "sed iompi.h failed"

	fix_scons {gambatte_sdl,libgambatte}/SConstruct
}

src_compile() {
	# build core library
	cd "${S}"/libgambatte || die
	escons

	# build sdl frontend
	if use sdl; then
		cd "${S}"/gambatte_sdl || die
		escons
	fi

	# build qt frontend
	if use qt4; then
		cd "${S}"/gambatte_qt || die
		eqmake4 ${PN}_qt.pro
		emake
	fi
}

src_install() {
	use sdl && dogamesbin gambatte_sdl/gambatte_sdl
	use qt4 && dogamesbin gambatte_qt/bin/gambatte_qt

	nonfatal dodoc README changelog

	prepgamesdirs
}
