# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/nut/nut-18.10.ebuild,v 1.1 2013/07/30 06:23:14 radhermit Exp $

EAPI=5
inherit toolchain-funcs

DESCRIPTION="Record what you eat and analyze your nutrient levels"
HOMEPAGE="http://nut.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ppc ~x86"

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		OPT="${CFLAGS}" FOODDIR=\\\"/usr/share/nut\\\" \
		nut
}

src_install() {
	insinto /usr/share/nut
	doins raw.data/*

	dobin nut
	doman nut.1
}
