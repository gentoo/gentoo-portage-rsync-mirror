# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dgen-sdl/dgen-sdl-1.32.ebuild,v 1.1 2013/06/24 17:13:55 mr_bones_ Exp $

EAPI=5
inherit games

DESCRIPTION="A Linux/SDL-Port of the famous DGen MegaDrive/Genesis-Emulator"
HOMEPAGE="http://dgen.sourceforge.net/"
SRC_URI="mirror://sourceforge/dgen/files/${P}.tar.gz"

LICENSE="dgen-sdl BSD BSD-2 free-noncomm LGPL-2.1+ GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="joystick opengl"

RDEPEND="media-libs/libsdl[joystick?]
	app-arch/libarchive
	opengl? ( virtual/opengl )"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"

src_configure() {
	egamesconf \
		$(use_enable x86 asm) \
		$(use_enable joystick) \
		$(use_enable opengl)
}

src_compile() {
	emake -C musa m68kops.h
	emake
}

src_install() {
	DOCS="AUTHORS ChangeLog README sample.dgenrc" default
	prepgamesdirs
}
