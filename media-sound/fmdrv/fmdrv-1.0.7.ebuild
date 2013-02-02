# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/fmdrv/fmdrv-1.0.7.ebuild,v 1.9 2013/02/02 18:52:06 ulm Exp $

inherit toolchain-funcs

DESCRIPTION="Console mode MIDI player with builtin userland OPL2 driver"
HOMEPAGE="http://bisqwit.iki.fi/source/fmdrv.html"
SRC_URI="http://bisqwit.iki.fi/src/arch/${P}.tar.bz2"

LICENSE="fmdrv GPL-2" # GPL-2 only
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

src_compile() {
	emake fmdrv \
		CC="$(tc-getCC)" CXX="$(tc-getCXX)" \
		CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" \
		LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	dobin fmdrv
	dodoc README
	dohtml README.html
}

pkg_postinst() {
	elog "If you want to use AdLib (FM OPL2), you need to setuid /usr/bin/fmdv."
	elog "chmod 4711 /usr/bin/fmdrv"
}
