# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/cernlib-montecarlo/cernlib-montecarlo-2006-r3.ebuild,v 1.4 2013/01/17 18:53:15 bicatali Exp $

EAPI=4

inherit eutils toolchain-funcs

DEB_PN=mclibs
DEB_PV=20061220+dfsg3
DEB_PR=1
DEB_P=${DEB_PN}_${DEB_PV}

DESCRIPTION="Monte-carlo library and tools for the cernlib"
HOMEPAGE="http://wwwasd.web.cern.ch/wwwasd/cernlib"
SRC_URI="
	mirror://debian/pool/main/${DEB_PN:0:1}/${DEB_PN}/${DEB_P}.orig.tar.gz
	mirror://debian/pool/main/${DEB_PN:0:1}/${DEB_PN}/${DEB_P}-${DEB_PR}.debian.tar.gz"

SLOT="0"
LICENSE="GPL-2 LGPL-2 BSD"
IUSE="+herwig"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

RDEPEND="
	x11-libs/motif:0
	dev-lang/cfortran
	sci-physics/cernlib
	herwig? ( !sci-physics/herwig )"

DEPEND="${RDEPEND}
	virtual/latex-base
	x11-misc/imake
	x11-misc/makedepend"

S="${WORKDIR}/${DEB_PN}-${DEB_PV}.orig"

src_prepare() {
	mv ../debian . || die
	cp debian/add-ons/Makefile . || die
	export DEB_BUILD_OPTIONS="$(tc-getFC) nostrip nocheck"
	sed -i \
		-e "s:/usr/local:${EROOT}/usr:g" \
		Makefile || die

	einfo "Applying Debian patches"
	emake -j1 patch
	use herwig || epatch "${FILESDIR}"/${P}-noherwig.patch
	# since we depend on cfortran, do not use the one from cernlib
	rm src/include/cfortran/cfortran.h || die
}

src_compile() {
	VARTEXFONTS="${T}"/fonts
	emake -j1 cernlib-indep cernlib-arch
}

src_test() {
	LD_LIBRARY_PATH="${S}"/shlib \
		emake -j1 cernlib-test
}

src_install() {
	emake DESTDIR="${D}" MCDOC="${ED}usr/share/doc/${PF}" install
	cd debian
	dodoc changelog README.* deadpool.txt copyright
	newdoc add-ons/README README.add-ons
}
