# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/psutils/psutils-1.17.ebuild,v 1.32 2011/02/06 06:01:23 leio Exp $

inherit toolchain-funcs

DESCRIPTION="PostScript Utilities"
HOMEPAGE="http://www.tardis.ed.ac.uk/~ajcd/psutils"
SRC_URI="ftp://ftp.enst.fr/pub/unix/a2ps/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-lang/perl"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	sed \
		-e "s:/usr/local:\$(DESTDIR)/usr:" \
		-e "s:-DUNIX -O:-DUNIX ${CFLAGS}:" \
		"${S}/Makefile.unix" > "${S}/Makefile"
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install () {
	dodir /usr/{bin,share/man}
	make DESTDIR="${D}" install || die
	dodoc README
}
