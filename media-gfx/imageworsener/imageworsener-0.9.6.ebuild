# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/imageworsener/imageworsener-0.9.6.ebuild,v 1.1 2012/01/01 12:05:47 sping Exp $

EAPI="2"

CMAKE_IN_SOURCE_BUILD=1
CMAKE_VERBOSE=1
inherit eutils cmake-utils

MY_P="${PN}-src-${PV}"
MY_PN="imagew"

DESCRIPTION="Utility for image scaling and processing"
HOMEPAGE="http://entropymine.com/imageworsener/"
SRC_URI="http://entropymine.com/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test webp"

WEBP_DEPEND='>=media-libs/libwebp-0.1.3'
DEPEND="media-libs/libpng:0
	virtual/jpeg
	webp? ( ${WEBP_DEPEND} )
	test? ( ${WEBP_DEPEND} )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.9.5-webp.patch
}

src_configure() {
	local webp=0
	use webp && webp=1
	use test && webp=1
	mycmakeargs=( -DIW_SUPPORT_WEBP=${webp} )

	cmake-utils_src_configure
}

src_install() {
	dobin ${MY_PN} || die "dobin failed."
	dodoc readme.txt technical.txt changelog.txt || die
}

src_test() {
	cd "${S}/tests" || die
	./runtest "${S}/${MY_PN}"
}
