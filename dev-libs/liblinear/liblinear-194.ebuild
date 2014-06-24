# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/liblinear/liblinear-194.ebuild,v 1.5 2014/06/24 19:21:59 maekke Exp $

EAPI=5
inherit multilib toolchain-funcs

DESCRIPTION="A Library for Large Linear Classification"
HOMEPAGE="http://www.csie.ntu.edu.tw/~cjlin/liblinear/ https://github.com/cjlin1/liblinear"
SRC_URI="https://github.com/cjlin1/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86"

# /usr/bin/predict collision
RDEPEND="!sci-astronomy/predict"

src_prepare() {
	sed -i \
		-e '/^AR/s|=|?=|g' \
		-e '/^RANLIB/s|=|?=|g' \
		-e '/^CFLAGS/d;/^CXXFLAGS/d' \
		blas/Makefile || die
	sed -i \
		-e 's|make|$(MAKE)|g' \
		-e '/$(LIBS)/s|$(CFLAGS)|& $(LDFLAGS)|g' \
		-e '/^CFLAGS/d;/^CXXFLAGS/d' \
		-e 's|$${SHARED_LIB_FLAG}|& $(LDFLAGS)|g' \
		Makefile || die
}

src_compile() {
	CC=$(tc-getCC) \
		CXX=$(tc-getCXX) \
		CFLAGS="${CFLAGS} -fPIC" \
		CXXFLAGS="${CXXFLAGS} -fPIC" \
		AR="$(tc-getAR) rcv" \
		RANLIB="$(tc-getRANLIB)" \
		emake lib all
}

src_install() {
	dolib ${PN}.so.1
	dosym ${PN}.so.1 /usr/$(get_libdir)/${PN}.so

	dobin predict train

	insinto /usr/include
	doins linear.h

	dodoc README
}
