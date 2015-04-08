# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/normaliz/normaliz-2.5-r1.ebuild,v 1.9 2014/08/18 07:33:26 tomka Exp $

EAPI=2

inherit eutils toolchain-funcs

MYP="Normaliz${PV}"

DESCRIPTION="tool for computations in affine monoids and more"
HOMEPAGE="http://www.mathematik.uni-osnabrueck.de/normaliz/"
SRC_URI="http://www.mathematik.uni-osnabrueck.de/${PN}/${MYP}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="extras openmp"

RDEPEND="dev-libs/gmp[cxx]"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${MYP}

src_prepare () {
	epatch "${FILESDIR}/${P}-respect-flags.patch"

	if use openmp && tc-has-openmp; then
		export OPENMP=yes
	else
		export OPENMP=no
	fi
}

src_compile(){
	emake CXX="$(tc-getCXX)" OPENMP="${OPENMP}" -C source || die
}

src_install() {
	dobin source/{norm64,normbig} || die
	dodoc doc/"${MYP}Documentation.pdf" || die
	if use extras; then
		elog "You have selected to install extras which consist of Macaulay2"
		elog "and Singular packages. These have been installed into "
		elog "/usr/share/${PN}, and cannot be used without additional setup. Please refer"
		elog "to the homepages of the respective projects for additional information."
		elog "Note however, Gentoo's versions of Singular and Macaulay2 bring their own"
		elog "copies of these interface packages. Usually you don't need normaliz's versions."
		insinto "/usr/share/${PN}"
		doins Singular/normaliz.lib
		doins Macaulay2/Normaliz.m2
	fi
}
