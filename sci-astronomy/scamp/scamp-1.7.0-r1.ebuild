# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/scamp/scamp-1.7.0-r1.ebuild,v 1.3 2012/08/05 19:21:51 bicatali Exp $

EAPI=4
inherit eutils

DESCRIPTION="Astrometric and photometric solutions for astronomical images"
HOMEPAGE="http://www.astromatic.net/software/scamp"
SRC_URI="http://www.astromatic.net/download/${PN}/${P}.tar.gz"

LICENSE="CeCILL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc threads plplot"

RDEPEND=">=sci-astronomy/cdsclient-3.4
	virtual/cblas
	>=sci-libs/lapack-atlas-3.8.0
	sci-libs/fftw:3.0
	plplot? ( sci-libs/plplot )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	# gentoo uses cblas instead of ptcblas (linked to threaded with eselect)
	sed -i \
		-e 's/ptcblas/cblas/g' \
		configure || die "sed failed"
	epatch "${FILESDIR}"/${P}-plplot599.patch
}

src_configure() {
	econf \
		--with-atlas-incdir="${EROOT}/usr/include/atlas" \
		$(use_with plplot) \
		$(use_enable threads)
}

src_install () {
	default
	use doc && dodoc doc/*
}
