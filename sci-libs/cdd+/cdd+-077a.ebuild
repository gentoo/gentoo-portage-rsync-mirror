# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cdd+/cdd+-077a.ebuild,v 1.3 2011/01/02 09:20:07 phajdan.jr Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="Another implementation of the double description method"
HOMEPAGE="http://www.ifor.math.ethz.ch/~fukuda/cdd_home/"
SRC_URI="ftp://ftp.ifor.math.ethz.ch/pub/fukuda/cdd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-libs/gmp"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-headers.patch"
	epatch "${FILESDIR}/${P}-gentoo.patch"
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		LIBDIR="${EPREFIX}/usr/$(get_libdir)" \
		GMPLIBDIR="${EPREFIX}/usr/$(get_libdir)" \
		GMPINCLUDE="${EPREFIX}/usr/include" \
		all || die

}

src_install() {
	dobin cddr+ cddf+ || die
}
