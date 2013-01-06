# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/sextractor/sextractor-2.8.6.ebuild,v 1.2 2012/04/26 16:35:34 jlec Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=yes

inherit autotools-utils multilib

DESCRIPTION="Extract catalogs of sources from astronomical FITS images"
HOMEPAGE="http://astromatic.iap.fr/software/sextractor/"
SRC_URI="ftp://ftp.iap.fr/pub/from_users/bertin/${PN}/${P}.tar.gz"

LICENSE="CeCILL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc threads"

RDEPEND="
	virtual/cblas
	sci-libs/lapack-atlas
	sci-libs/fftw:3.0"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/${PN}-configure.patch )

src_prepare() {
	# gentoo uses cblas instead of ptcblas (linked to threaded with eselect)
	sed \
		-e 's/ptcblas/cblas/g' \
		-i acx_atlas.m4 || die "sed acx_atlas.m4 failed"
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		--with-atlas="/usr/$(get_libdir)/lapack/atlas"
		$(use_enable threads)
		)
	autotools-utils_src_configure
}

src_install () {
	autotools-utils_src_install

	insinto /usr/share/sextractor
	doins config/*

	use doc && dodoc doc/*
}

pkg_postinst() {
	elog "SExtractor examples configuration files are located"
	elog "in ${CONFDIR} and are not loaded anymore by default."
}
