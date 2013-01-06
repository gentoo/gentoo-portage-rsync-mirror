# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/uisp/uisp-20050207-r1.ebuild,v 1.3 2007/10/20 20:58:26 calchan Exp $

inherit eutils

DESCRIPTION="tool for AVR microcontrollers which can interface to many hardware in-system programmers"
HOMEPAGE="http://savannah.nongnu.org/projects/uisp"
SRC_URI="http://savannah.nongnu.org/download/uisp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="sys-apps/gawk
	sys-devel/gcc"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"/src
	epatch "${FILESDIR}"/mega-48-88-168.patch
	sed -i -e 's: -Werror::' Makefile.in
}

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc doc/*
	mv "${D}"/usr/share/doc/${P}/{AUTHORS,ChangeLog,CHANGES,TODO}* "${D}"/usr/share/doc/${PF}
	rm -rf "${D}"/usr/share/doc/${P}
	prepalldocs
}
