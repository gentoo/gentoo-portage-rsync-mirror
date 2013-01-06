# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/pcalc/pcalc-2.ebuild,v 1.3 2012/08/04 22:29:20 bicatali Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="the programmers calculator"
HOMEPAGE="http://pcalc.sourceforge.net/"
SRC_URI="mirror://sourceforge/pcalc/${P}.tar.lzma"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="sys-devel/flex"
RDEPEND=""

src_prepare() {
	sed -i -e "s:/usr:${EPREFIX}/usr:g" Makefile || die
}

src_compile() {
	tc-export CC
	emake pcalc
}
