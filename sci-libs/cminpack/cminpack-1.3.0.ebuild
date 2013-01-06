# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cminpack/cminpack-1.3.0.ebuild,v 1.2 2012/08/03 17:22:14 bicatali Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="C implementation of the MINPACK nonlinear optimization library"
HOMEPAGE="http://devernay.free.fr/hacks/cminpack/"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc test"

PATCHES=( "${FILESDIR}"/${PN}-1.2.2-underlinking.patch )

src_configure() {
	mycmakeargs+=(
		-DSHARED_LIBS=ON
		$(cmake-utils_use_build test examples)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc readme*
	use doc && dohtml -A .txt doc/*
}
