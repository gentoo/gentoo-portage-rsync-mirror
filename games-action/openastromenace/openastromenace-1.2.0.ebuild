# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/openastromenace/openastromenace-1.2.0.ebuild,v 1.10 2011/07/07 02:41:31 mr_bones_ Exp $

EAPI=2
inherit flag-o-matic cmake-utils eutils games

DESCRIPTION="Modern 3D space shooter with spaceship upgrade possibilities"
HOMEPAGE="http://sourceforge.net/projects/openastromenace/"
SRC_URI="mirror://sourceforge/${PN}/openamenace-src-${PV}.tar.bz2
	mirror://sourceforge/${PN}/oamenace-data-${PV}.tar.bz2
	linguas_en? ( mirror://sourceforge/${PN}/oamenace-lang-en-${PV}.tar.bz2 )
	linguas_de? ( mirror://sourceforge/${PN}/oamenace-lang-de-${PV}.tar.bz2 )
	linguas_ru? ( mirror://sourceforge/${PN}/oamenace-lang-ru-${PV}.tar.bz2 )
	!linguas_en? ( !linguas_de? ( !linguas_ru? ( mirror://sourceforge/${PN}/oamenace-lang-en-${PV}.tar.bz2 ) ) )
	mirror://gentoo/${PN}.png"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="linguas_en linguas_de linguas_ru"

DEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl[joystick,video,X]
	media-libs/openal
	media-libs/freealut
	media-libs/libogg
	media-libs/libvorbis
	virtual/jpeg"

S=${WORKDIR}/OpenAstroMenaceSVN

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-cmake.patch \
		"${FILESDIR}"/${P}-mesa.patch
	if use linguas_en ; then
		einfo "Picking en for language set"
		mv ../gamelang_en.vfs ../gamelang.vfs
	elif use linguas_de ; then
		einfo "Picking de for language set"
		sed -i \
			-e '/^#define EN/s:^://:' \
			-e '/#define DE/s://::' \
			AstroMenaceSource/Defines.h \
			|| die "sed failed"
		mv ../gamelang_de.vfs ../gamelang.vfs
	elif use linguas_ru ; then
		einfo "Picking ru for language set"
		sed -i \
			-e '/^#define EN/s:^://:' \
			-e '/#define RU/s://::' \
			AstroMenaceSource/Defines.h \
			|| die "sed failed"
		mv ../gamelang_ru.vfs ../gamelang.vfs
	else
		einfo "Picking en for language set"
		mv ../gamelang_en.vfs ../gamelang.vfs
	fi
	rm -f ../gamelang_*
}

src_configure() {
	local mycmakeargs="-DDATADIR=${GAMES_DATADIR}/${PN}"

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	newgamesbin "${CMAKE_BUILD_DIR}"/AstroMenace ${PN} \
		|| die "newgamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r ../DATA ../*.vfs || die "doins failed"
	doicon "${DISTDIR}"/${PN}.png
	make_desktop_entry ${PN} OpenAstroMenace
	dodoc ReadMe.txt
	prepgamesdirs
}
