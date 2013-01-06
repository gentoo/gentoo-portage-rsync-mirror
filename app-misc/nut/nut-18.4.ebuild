# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/nut/nut-18.4.ebuild,v 1.1 2012/11/19 12:28:47 jer Exp $

EAPI=4
inherit eutils toolchain-funcs

DESCRIPTION="Record what you eat and analyze your nutrient levels"
HOMEPAGE="http://nut.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ppc ~x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${PN}-17.12-makefile.patch
}

src_compile() {
	emake CC="$(tc-getCC)" OPT="${CFLAGS}" FOODDIR=\\\"/usr/share/nut\\\"
}

src_install() {
	insinto /usr/share/nut
	doins raw.data/*
	dobin nut
	doman nut.1
}
