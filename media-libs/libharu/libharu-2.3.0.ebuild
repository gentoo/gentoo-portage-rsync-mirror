# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libharu/libharu-2.3.0.ebuild,v 1.1 2014/02/19 20:25:05 bicatali Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=1

inherit autotools-utils

MYP=RELEASE_${PV//./_}

DESCRIPTION="C/C++ library for PDF generation"
HOMEPAGE="http://www.libharu.org/"
SRC_URI="https://github.com/${PN}/${PN}/archive/${MYP}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="png static-libs zlib"

DEPEND="
	png? ( media-libs/libpng )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MYP}"

PATCHES=( "${FILESDIR}"/${P}-dont-force-strip.patch )

src_configure() {
	local myeconfargs=(
		$(use_with png png "${EPREFIX}"/usr)
		$(use_with zlib)
	)
	autotools-utils_src_configure
}
