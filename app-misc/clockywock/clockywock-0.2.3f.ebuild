# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/clockywock/clockywock-0.2.3f.ebuild,v 1.6 2012/03/20 18:27:34 sping Exp $

EAPI="4"

inherit eutils toolchain-funcs

MY_P=${P/f/F}

DESCRIPTION="ncurses based analog clock"
HOMEPAGE="http://dentar.com/ourway/opensource"
SRC_URI="http://dentar.com/opensource/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
	sed -i 's:\<timex\>:timecw:g' clockywock.cpp || die #371383
}

src_compile() {
	tc-export CXX
	emake || die
}

src_install() {
	dobin ${PN}
	doman ${PN}.7
	dodoc README CREDITS
}
