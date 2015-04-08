# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mosml/mosml-2.01-r1.ebuild,v 1.10 2012/10/10 15:33:05 ranger Exp $

EAPI="3"

inherit eutils

DESCRIPTION="Moscow ML - a lightweight implementation of Standard ML (SML)"
SRC_URI="http://www.itu.dk/people/sestoft/mosml/mos201src.tar.gz"
HOMEPAGE="http://www.itu.dk/people/sestoft/mosml.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}/src"

src_prepare() {
	epatch "${FILESDIR}/${P}-malloc.patch" #154859

	#Fixing pre-stripped files
	sed -i -e "/STRIP/d" mosmlyac/Makefile || die "sed Makefile failed"
	sed -i -e "/STRIP/d" runtime/Makefile || die "sed Makefile failed"
	sed -i -e 's/make/$(MAKE)/g' Makefile runtime/Makefile mosmlyac/Makefile \
		mosmllib/Makefile  compiler/Makefile toolssrc/Makefile lex/Makefile \
		launch/Makefile doc/Makefile config/Makefile || die "Sed failed"
	sed -i -e 's/$(LD)/$(LD) $(LDFLAGS)/g' runtime/Makefile || die "Sed failed"
	sed -i -e "s|^CPP=/lib/cpp|CPP=${EPREFIX}/usr/bin/cpp|" Makefile.inc \
		|| die "Sed failed"
	sed -i -e 's/$(CC) $(CFLAGS)/$(CC) $(LDFLAGS)/' mosmlyac/Makefile || die "Sed failed"
}

src_configure() { :; }

src_compile() {
	emake CC=$(tc-getCC) CPP="$(tc-getCPP) -P -traditional -Dunix -Umsdos" \
		MOSMLHOME="${EPREFIX}"/opt/mosml world || die
}

src_install() {
	emake MOSMLHOME="${ED}"/opt/mosml install || die
	rm "${ED}"opt/mosml/lib/camlrunm || die # This is a bad symlink
	echo "#!${EPREFIX}/opt/mosml/bin/camlrunm" > "${ED}"opt/mosml/lib/header

	dodoc  ../README || die
	dosym  /opt/mosml/bin/mosml     /usr/bin/mosml || die
	dosym  /opt/mosml/bin/mosmlc    /usr/bin/mosmlc || die
	dosym  /opt/mosml/bin/mosmllex  /usr/bin/mosmllex || die
	dosym  /opt/mosml/bin/mosmlyac  /usr/bin/mosmlyac || die
	dosym  /opt/mosml/bin/camlrunm  /usr/bin/camlrunm || die
	dosym  /opt/mosml/bin/camlrunm  /opt/mosml/lib/camlrunm || die
}
