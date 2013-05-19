# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/nut/nut-18.8.ebuild,v 1.2 2013/05/19 10:14:59 ago Exp $

EAPI=5
inherit toolchain-funcs

DESCRIPTION="Record what you eat and analyze your nutrient levels"
HOMEPAGE="http://nut.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ppc ~x86"

src_compile() {
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" OPT="${CFLAGS}" FOODDIR=\\\"/usr/share/nut\\\"
}

src_install() {
	insinto /usr/share/nut
	doins raw.data/*
	dobin nut
	doman nut.1
}
