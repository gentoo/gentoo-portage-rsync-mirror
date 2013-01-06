# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-gpupetexgl2/psemu-gpupetexgl2-2.0.8.ebuild,v 1.3 2009/01/27 06:25:30 mr_bones_ Exp $

EAPI=1
inherit games

DESCRIPTION="PSEmu XGL2 GPU"
HOMEPAGE="http://www.pbernert.com/"
SRC_URI="http://www.pbernert.com/gpupetexgl${PV//.}.tar.gz
	http://www.pbernert.com/pete_ogl2_shader_scale2x.zip
	http://www.pbernert.com/pete_ogl2_shader_simpleblur.zip"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RESTRICT="strip"

RDEPEND="virtual/opengl
	x11-libs/gtk+:1"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}

src_install() {
	exeinto "$(games_get_libdir)"/psemu/plugins
	doexe lib* || die "doexe failed"
	exeinto "$(games_get_libdir)"/psemu/cfg
	doexe cfgPeteXGL2 || die "doexe failed"
	insinto "$(games_get_libdir)"/psemu/cfg
	doins gpuPeteXGL2.cfg || die "doins failed"
	# now do our shader files!
	insinto "$(games_get_libdir)"/psemu/shaders
	doins *.fp *.vp *.slf *.slv || die "doins failed"
	dodoc *.txt
	prepgamesdirs
}
