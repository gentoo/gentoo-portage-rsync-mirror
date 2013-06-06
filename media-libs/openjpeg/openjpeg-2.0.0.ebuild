# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openjpeg/openjpeg-2.0.0.ebuild,v 1.2 2013/06/06 13:54:04 xmw Exp $

EAPI=5
inherit cmake-utils multilib

DESCRIPTION="An open-source JPEG 2000 library"
HOMEPAGE="http://code.google.com/p/openjpeg/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="doc test"

RDEPEND="media-libs/lcms:2=
	media-libs/libpng:0=
	media-libs/tiff:0=
	sys-libs/zlib:="
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

DOCS=( AUTHORS CHANGES NEWS README THANKS )

PATCHES=( "${FILESDIR}"/${P}-build.patch
	"${FILESDIR}"/${P}-pkgconfig.patch )

RESTRICT="test" #409263

src_configure() {
	local mycmakeargs=(
		-DOPENJPEG_INSTALL_LIB_DIR="$(get_libdir)"
		$(cmake-utils_use_build doc)
		$(cmake-utils_use_build test TESTING)
		)

	cmake-utils_src_configure
}
