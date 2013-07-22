# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libsolv/libsolv-0.3.0.ebuild,v 1.2 2013/07/22 04:25:42 scarabeus Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="Library for solving packages and reading repositories"
HOMEPAGE="http://doc.opensuse.org/projects/libzypp/HEAD/"
SRC_URI="https://build.opensuse.org/package/rawsourcefile/openSUSE:Factory/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="bzip2 lzma" # perl python ruby"

RDEPEND="
	app-arch/rpm
	dev-libs/expat
	sys-libs/db
	sys-libs/zlib
	virtual/udev
	bzip2? ( app-arch/bzip2 )
	lzma? ( app-arch/xz-utils )
"
DEPEND="${DEPEND}
	sys-devel/gettext
"

src_prepare() {
	# enabling suse features also mess up headers detection
	sed -i \
		-e "s:include <rpm/db.h>:include <db.h>:g" \
		ext/repo_rpmdb.c || die
	# respect ldflags
	sed -i \
		-e 's:LINK_FLAGS}:LINK_FLAGS} ${CMAKE_SHARED_LINKER_FLAGS}:g' \
		src/CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		"-DSUSE=1"
		"-DENABLE_SUSEREPO=1"
		"-DENABLE_HELIXREPO=1"
		"-DUSE_VENDORDIRS=1"
		$(cmake-utils_use_enable bzip2 ENABLE_BZIP2_COMPRESSION)
		$(cmake-utils_use_enable lzma ENABLE_LZMA_COMPRESSION)
	)

	cmake-utils_src_configure
}
