# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/cvmfs/cvmfs-2.1.10.ebuild,v 1.1 2013/06/17 23:03:46 bicatali Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="HTTP read-only file system for distributing software"
HOMEPAGE="http://cernvm.cern.ch/portal/filesystem"
SRC_URI="https://ecsft.cern.ch/dist/${PN}/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"

IUSE="+client debug doc server"

CDEPEND="
	dev-db/sqlite:3
	dev-libs/openssl
	net-dns/c-ares
	net-misc/curl[adns]
	sys-libs/zlib
	client? (
		dev-cpp/sparsehash
		dev-libs/leveldb
		sys-fs/fuse )
	server? ( sys-libs/zlib )"

RDEPEND="${CDEPEND}
	client? ( net-fs/autofs )
	server? ( www-servers/apache[ssl] )"

DEPEND="${CDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen[dot] )"

PATCHES=(
	"${FILESDIR}"/${P}-no-config.patch
	"${FILESDIR}"/${P}-openrc.patch
)

src_prepare() {
	sed -i -e 's/COPYING//' CMakeLists.txt || die
	cp "${FILESDIR}"/Find*.cmake cmake/Modules/ || die
	rm bootstrap.sh || die
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCARES_BUILTIN=OFF
		-DSQLITE3_BUILTIN=OFF
		-DLIBCURL_BUILTIN=OFF
		-DZLIB_BUILTIN=OFF
		-DSPARSEHASH_BUILTIN=OFF
		-DLEVELDB_BUILTIN=OFF
		$(cmake-utils_use debug BUILD_SERVER_DEBUG)
		$(cmake-utils_use server BUILD_SERVER)
		$(cmake-utils_use client BUILD_CVMFS)
		$(cmake-utils_use client BUILD_LIBCVMFS)
		$(cmake-utils_use client INSTALL_MOUNT_SCRIPTS)
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	if use doc; then
		cd doc
		doxygen cvmfs.doxy || die
	fi
}

src_install() {
	cmake-utils_src_install
	use doc && dohtml -r doc/html/*
}

pkg_config() {
	if use client; then
		einfo "Setting up CernVM-FS client"
		cvmfs_config setup
		einfo "Now edit ${EROOT%/}/etc/cvmfs/default.local and run"
		einfo "  ${EROOT%/}/usr/init.d/autofs restart"
	fi
}
