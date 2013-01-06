# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-gpupetemesagl/psemu-gpupetemesagl-1.76.ebuild,v 1.4 2009/01/27 06:27:45 mr_bones_ Exp $

EAPI=1
inherit games

DESCRIPTION="PSEmu MesaGL GPU"
HOMEPAGE="http://www.pbernert.com/"
SRC_URI="http://www.pbernert.com/gpupetemesagl${PV//./}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RESTRICT="strip"

RDEPEND="virtual/opengl
	x11-libs/gtk+:1"

S=${WORKDIR}

src_install() {
	exeinto "$(games_get_libdir)"/psemu/plugins
	doexe lib* || die "doexe failed"
	exeinto "$(games_get_libdir)"/psemu/cfg
	doexe cfgPeteMesaGL || die "doexe failed"
	insinto "$(games_get_libdir)"/psemu/cfg
	doins gpuPeteMesaGL.cfg || die "doins failed"
	dodoc readme.txt version.txt
	prepgamesdirs
}
