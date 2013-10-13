# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/lz4/lz4-9999.ebuild,v 1.7 2013/10/13 11:33:59 ryao Exp $

EAPI=5

inherit cmake-utils multilib

CMAKE_USE_DIR="${S}/cmake"

if [ ${PV} == "9999" ] ; then
	inherit subversion
	ESVN_REPO_URI="http://lz4.googlecode.com/svn/trunk/"
	ESVN_PROJECT="lz4-read-only"
else
	SRC_URI="http://dev.gentoo.org/~ryao/dist/${P}.tar.xz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Extremely Fast Compression algorithm"
HOMEPAGE="https://code.google.com/p/lz4/"

LICENSE="BSD-2"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	[ ${PV} == "9999" ] && subversion_src_prepare
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(-DBUILD_SHARED_LIBS=ON)
	cmake-utils_src_configure
}

src_install() {
	dodir /usr
	dodir "/usr/$(get_libdir)"
	ln -s "${ED}/usr/$(get_libdir)" "${ED}usr/lib" || \
		die "Cannot create temporary symlink from usr/lib to usr/$(get_libdir)"

	cmake-utils_src_install

	rm "${ED}usr/lib"

	if [ -f "${ED}usr/bin/lz4c64" ]
	then
		dosym /usr/bin/{lz4c64,lz4c}
	else
		dosym /usr/bin/{lz4c32,lz4c}
	fi
}
