# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cmocka/cmocka-0.2.0_p20121129.ebuild,v 1.1 2012/12/14 17:04:36 creffett Exp $

EAPI=4

inherit cmake-utils
DESCRIPTION="The lightweight C unit testing library"
HOMEPAGE="https://open.cryptomilk.org/projects/cmocka"
SRC_URI="http://dev.gentoo.org/~creffett/distfiles/${P}.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"

DEPEND="
	doc? ( app-doc/doxygen[latex] )
"
RDEPEND=""

PATCHES=( "${FILESDIR}/${PN}-automagicness.patch" )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with static-libs STATIC_LIB)
		$(cmake-utils_use test UNIT_TESTING)
		$(cmake-utils_use_with doc APIDOC)
	)
	cmake-utils_src_configure
}

src_install() {
	if use doc; then
		pushd ${BUILD_DIR}/doc/
		doxygen doxy.config
		rm html/*.md5 latex/*.md5 latex/Manifest man/man3/_*
		dohtml html/*
		dodoc latex/*
		doman man/man3/*.3
		popd
	fi
	cmake-utils_src_install
}
