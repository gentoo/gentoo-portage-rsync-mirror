# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libfaketime/libfaketime-0.9.1.ebuild,v 1.1 2012/10/23 22:26:58 radhermit Exp $

EAPI=5

inherit eutils toolchain-funcs multilib

DESCRIPTION="Report faked system time to programs"
HOMEPAGE="http://www.code-wizards.com/projects/libfaketime/"
SRC_URI="http://www.code-wizards.com/projects/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
	epatch "${FILESDIR}"/${PN}-0.9-as-needed.patch
	tc-export CC
}

src_install() {
	dobin src/faketime
	doman man/faketime.1
	exeinto /usr/$(get_libdir)/faketime
	doexe src/${PN}*.so.*
	dosym ${PN}.so.1 /usr/$(get_libdir)/faketime/${PN}.so
	dosym ${PN}MT.so.1 /usr/$(get_libdir)/faketime/${PN}MT.so
	dodoc NEWS README TODO
}
