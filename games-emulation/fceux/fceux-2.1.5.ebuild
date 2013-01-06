# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/fceux/fceux-2.1.5.ebuild,v 1.4 2012/10/26 07:31:49 tupone Exp $

EAPI=4
inherit eutils scons-utils games

DESCRIPTION="A portable Famicom/NES emulator, an evolution of the original FCE Ultra"
HOMEPAGE="http://fceux.com/"
SRC_URI="mirror://sourceforge/fceultra/${P}.src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+lua +opengl"

RDEPEND="lua? ( dev-lang/lua )
	media-libs/libsdl[opengl?,video]
	opengl? ( virtual/opengl )
	x11-libs/gtk+:2
	sys-libs/zlib
	gnome-extra/zenity"
DEPEND="${RDEPEND}"

# Note: zenity is "almost" optional. It is possible to compile and run fceux
# without zenity, but file dialogs will not work.

S=${WORKDIR}/fceu${PV}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-underlink.patch \
		"${FILESDIR}"/${P}-gcc46.patch \
		"${FILESDIR}"/${P}-gcc47.patch
	# mentioned in bug #335836
	if ! use lua ; then
		sed -i -e '/_S9XLUA_H/d' SConstruct || die
	fi
}

src_compile() {
	escons \
		CREATE_AVI=1 \
		$(use_scons opengl OPENGL) \
		$(use_scons lua LUA)
}

src_install() {
	dogamesbin bin/fceux

	doman documentation/fceux.6
	docompress -x /usr/share/doc/${PF}/documentation
	docompress -x /usr/share/doc/${PF}/fceux.chm
	dodoc -r Authors.txt changelog.txt TODO-PROJECT bin/fceux.chm documentation
	rm -f "${D}/usr/share/doc/${PF}/documentation/fceux.6"

	prepgamesdirs
}
