# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/lensfun/lensfun-0.2.7.ebuild,v 1.12 2014/01/15 09:21:13 ago Exp $

EAPI=5

PYTHON_COMPAT=( python2_{6,7} )

inherit multilib python-single-r1 cmake-utils

DESCRIPTION="lensfun: A library for rectifying and simulating photographic lens distortions"
HOMEPAGE="http://lensfun.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="LGPL-3 CC-BY-SA-3.0" # See README for reasoning.
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ppc ppc64 ~s390 ~sh sparc x86 ~amd64-fbsd ~amd64-linux ~x86-linux"
IUSE="doc sse sse2"

RDEPEND=">=dev-libs/glib-2.28
	media-libs/libpng:0=
	sys-libs/zlib:="
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

PATCHES=(
	"${FILESDIR}"/${P}-build.patch
	"${FILESDIR}"/${PN}-0.2.6-auxfun.patch
	"${FILESDIR}"/${P}-memset.patch
	)

DOCS=( README docs/mounts.txt )

src_configure() {
	local mycmakeargs=(
		-DDOCDIR="${EPREFIX}"/usr/share/doc/${PF}/html
		-DLIBDIR=$(get_libdir)
		-DBUILD_AUXFUN=ON
		$(cmake-utils_use_build doc)
		$(cmake-utils_use_build sse FOR_SSE)
		$(cmake-utils_use_build sse2 FOR_SSE2)
		-DBUILD_STATIC=OFF
		-DBUILD_TESTS=OFF
		)

	cmake-utils_src_configure
}
