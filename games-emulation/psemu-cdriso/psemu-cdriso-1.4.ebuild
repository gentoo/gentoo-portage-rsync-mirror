# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-cdriso/psemu-cdriso-1.4.ebuild,v 1.12 2012/05/04 04:38:39 jdhore Exp $

inherit eutils games

DESCRIPTION="PSEmu plugin to read CD-images"
HOMEPAGE="http://www.pcsx.net/"
SRC_URI="http://linuzappz.pcsx.net/downloads/cdriso-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

RDEPEND="=x11-libs/gtk+-1.2*"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/cdriso

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PV}-makefile-cflags.patch
	cd "${S}"
	sed -i '/strip/d' src/Linux/Makefile || die "sed failed"
}

src_compile() {
	cd src/Linux
	emake OPTFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dodoc ReadMe.txt
	cd src/Linux
	exeinto "$(games_get_libdir)"/psemu/plugins
	doexe libcdriso-* || die "doexe failed"
	exeinto "$(games_get_libdir)"/psemu/cfg
	doexe cfgCdrIso || die "doexe failed"
	prepgamesdirs
}
