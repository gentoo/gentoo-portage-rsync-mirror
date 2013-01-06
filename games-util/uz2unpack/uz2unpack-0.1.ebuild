# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/uz2unpack/uz2unpack-0.1.ebuild,v 1.8 2009/11/03 21:40:12 nyhm Exp $

inherit toolchain-funcs

DESCRIPTION="UZ2 Decompressor for UT2003/UT2004"
HOMEPAGE="http://icculus.org/cgi-bin/ezmlm/ezmlm-cgi?42:mss:1013:200406:kikgppboefcimdbadcdo"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="sys-libs/zlib"

src_compile() {
	emake CC="$(tc-getCC)" LDLIBS=-lz ${PN} || die "emake failed"
}

src_install() {
	dobin ${PN} || die "dobin failed"
	dodoc README
}
