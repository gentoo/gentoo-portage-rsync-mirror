# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/joystick/joystick-0_pre20060731.ebuild,v 1.3 2012/06/14 14:45:16 xmw Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="joystick testing utilities"
HOMEPAGE="http://atrey.karlin.mff.cuni.cz/~vojtech/input/"
SRC_URI="mirror://gentoo/${P/0_pre}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="sdl"

DEPEND="sdl? ( media-libs/libsdl[video] )
	!x11-libs/tslib"

S=${WORKDIR}/utils

src_prepare() {
	epatch \
		"${FILESDIR}"/joystick-MCS-defines.patch \
		"${FILESDIR}"/joystick-jstest-segv.patch \
		"${FILESDIR}"/${P/0_pre}-asneeded.patch
	sed -i \
		-e '/^CC/d' \
		Makefile \
		|| die 'sed failed'
}

src_compile() {
	local SDL
	tc-export CC
	use sdl && SDL=1 || SDL=0
	emake SDL=${SDL} || die "emake failed"
	emake inputattach || die "inputattach failed"
}

src_install() {
	dobin $(find . -type f -a -perm +1) || die "dobin"
	dodoc README
}
