# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/vispatch/vispatch-1.4.5.ebuild,v 1.3 2011/01/12 22:43:46 mr_bones_ Exp $

EAPI=2
inherit toolchain-funcs

DESCRIPTION="WaterVIS utility for glquake"
HOMEPAGE="http://vispatch.sourceforge.net/"
SRC_URI="mirror://sourceforge/vispatch/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S=${WORKDIR}/${P}/source

src_prepare() {
	sed -i \
		-e '/^CFLAGS/d' \
		-e '/^LDFLAGS/d' \
		makefile \
		|| die "sed failed"
	tc-export CC
}

src_install() {
	dobin ${PN} || die "dobin failed"
	dodoc ${PN}.txt || die "dodoc failed"
}
