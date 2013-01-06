# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/emilia-pinball/emilia-pinball-0.3.1-r1.ebuild,v 1.8 2012/12/18 19:59:10 mr_bones_ Exp $

EAPI=2
inherit autotools eutils games

MY_PN=${PN/emilia-/}
MY_P=${MY_PN}-${PV}
DESCRIPTION="SDL OpenGL pinball game"
HOMEPAGE="http://pinball.sourceforge.net/"
SRC_URI="mirror://sourceforge/pinball/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

RDEPEND="virtual/opengl
	x11-libs/libSM
	media-libs/libsdl[joystick,opengl,video,X]
	media-libs/sdl-image[png]
	media-libs/sdl-mixer[vorbis]
	>=sys-devel/libtool-2.2.6b"
DEPEND="${RDEPEND}
	x11-libs/libXt"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i -e '/dnl/d' {src,test}/Makefile.am || die #334899
	epatch "${FILESDIR}"/${P}-glibc210.patch \
		"${FILESDIR}"/${P}-libtool.patch \
		"${FILESDIR}"/${P}-gcc46.patch \
		"${FILESDIR}"/${P}-parallel.patch
	rm -rf libltdl
	eautoreconf
}

src_configure() {
	egamesconf --with-x
}

src_compile() {
	emake CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	dodoc README || die
	emake DESTDIR="${D}" install || die
	dosym "${GAMES_BINDIR}"/pinball "${GAMES_BINDIR}"/emilia-pinball
	mv "${D}/${GAMES_PREFIX}/include" "${D}/usr/" || die
	dodir /usr/bin
	mv "${D}/${GAMES_BINDIR}/pinball-config" "${D}/usr/bin/" || die
	sed -i \
		-e 's:-I${prefix}/include/pinball:-I/usr/include/pinball:' \
		"${D}"/usr/bin/pinball-config || die
	newicon data/pinball.xpm ${PN}.xpm
	make_desktop_entry emilia-pinball "Emilia pinball"
	prepgamesdirs
}
