# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/fcl/fcl-9999.ebuild,v 1.1 2014/11/28 11:22:03 aballier Exp $

EAPI=5

SCM=""
if [ "${PV#9999}" != "${PV}" ] ; then
	SCM="git-r3"
	EGIT_REPO_URI="http://github.com/flexible-collision-library/fcl"
fi

inherit ${SCM} cmake-utils

if [ "${PV#9999}" != "${PV}" ] ; then
	KEYWORDS=""
	SRC_URI=""
else
	KEYWORDS="~amd64"
	SRC_URI="http://github.com/flexible-collision-library/fcl/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="The Flexible Collision Library"
HOMEPAGE="http://gamma.cs.unc.edu/FCL/"
LICENSE="BSD"
SLOT="0"
IUSE="sse"

RDEPEND="
	sci-libs/octomap
	sci-libs/flann
	dev-libs/boost:=[threads]
	sci-libs/libccd"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -e 's/DESTINATION lib/DESTINATION ${CMAKE_INSTALL_LIBDIR}/g' \
		-i src/CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		"-DFCL_USE_SSE=$(usex sse TRUE FALSE)"
	)
	cmake-utils_src_configure
}
