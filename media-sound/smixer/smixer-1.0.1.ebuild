# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/smixer/smixer-1.0.1.ebuild,v 1.17 2012/02/05 15:08:39 armin76 Exp $

inherit toolchain-funcs

IUSE=""

DESCRIPTION="A command-line tool for setting and viewing mixer settings"
HOMEPAGE="http://centerclick.org/programs/smixer/"
SRC_URI="http://centerclick.org/programs/smixer/${PN}${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86"

S="${WORKDIR}/${PN}"

src_compile() {
	emake LD="$(tc-getCC)" CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" LFLAGS="${LDFLAGS}" || die
}

src_install () {
	dodir /usr/bin /etc /usr/share/man/man1

	make \
		INS_BIN=${D}/usr/bin \
		INS_ETC=${D}/etc \
		INS_MAN=${D}/usr/share/man/man1 \
		install || die

	dodoc README
}
