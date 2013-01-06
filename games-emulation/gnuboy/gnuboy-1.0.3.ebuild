# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gnuboy/gnuboy-1.0.3.ebuild,v 1.14 2011/07/10 02:16:07 mr_bones_ Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="Gameboy emulator with multiple renderers"
HOMEPAGE="http://code.google.com/p/gnuboy/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="X fbcon sdl svga"

RDEPEND="sdl? ( media-libs/libsdl )
	!X? ( !svga? ( !fbcon? ( media-libs/libsdl ) ) )
	X? ( x11-libs/libXext )
	fbcon? ( sys-apps/fbset )"
DEPEND="${RDEPEND}
	svga? ( media-libs/svgalib )
	X? ( x11-proto/xextproto
		x11-proto/xproto )"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-exec-stack.patch \
		"${FILESDIR}"/${P}-linux-headers.patch
	eautoreconf
}

src_configure() {
	local myconf

	if ! use X && ! use svga && ! use fbcon; then
		myconf="--with-sdl"
	fi

	egamesconf \
		$(use_with X x) \
		$(use_with fbcon fb) \
		$(use_with sdl) \
		$(use_with svga svgalib) \
		$(use_enable x86 asm) \
		${myconf} \
		--disable-arch \
		--disable-optimize
}

src_install() {
	for f in fbgnuboy sdlgnuboy sgnuboy xgnuboy
	do
		if [[ -f ${f} ]] ; then
			dogamesbin ${f} || die "dogamesbin failed"
		fi
	done
	dodoc README docs/{CHANGES,CONFIG,CREDITS,FAQ,HACKING,WHATSNEW}
	prepgamesdirs
}
