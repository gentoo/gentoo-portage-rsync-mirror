# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/psutils/psutils-1.17-r1.ebuild,v 1.5 2012/05/09 16:30:11 aballier Exp $

EAPI=3

inherit toolchain-funcs eutils

DESCRIPTION="PostScript Utilities"
HOMEPAGE="http://www.tardis.ed.ac.uk/~ajcd/psutils"
SRC_URI="ftp://ftp.enst.fr/pub/unix/a2ps/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-lang/perl"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}/${P}-ldflags.patch"
	sed \
		-e "s:/usr/local:\$(DESTDIR)${EPREFIX}/usr:" \
		"${S}/Makefile.unix" > "${S}/Makefile"
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install () {
	dodir /usr/{bin,share/man}
	emake DESTDIR="${D}" install || die
	dodoc README
}
