# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libssh/libssh-9999.ebuild,v 1.6 2013/12/20 14:33:33 polynomial-c Exp $

# Maintainer: check IUSE-defaults at DefineOptions.cmake

EAPI=4

inherit eutils cmake-utils git-2

DESCRIPTION="Access a working SSH implementation by means of a library"
HOMEPAGE="http://www.libssh.org/"
EGIT_REPO_URI="git://git.libssh.org/projects/libssh.git"

LICENSE="LGPL-2.1"
KEYWORDS=""
SLOT="0"
IUSE="debug examples pcap +sftp ssh1 server static-libs zlib"

DEPEND="
	zlib? ( >=sys-libs/zlib-1.2 )
	>=dev-libs/openssl-0.9.8
"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS README ChangeLog )

src_prepare() {
	# just install the examples do not compile them
	sed -i \
		-e '/add_subdirectory(examples)/s/^/#DONOTWANT/' \
		CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with debug DEBUG_CALLTRACE)
		$(cmake-utils_use_with debug DEBUG_CRYPTO)
		$(cmake-utils_use_with pcap)
		$(cmake-utils_use_with server)
		$(cmake-utils_use_with sftp)
		$(cmake-utils_use_with ssh1)
		$(cmake-utils_use_with static-libs STATIC_LIB)
		$(cmake-utils_use_with zlib LIBZ)
		-DWITH_GCRYPT=OFF
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	if use examples; then
		insinto /usr/share/doc/"${PF}"/examples
		doins examples/*.{c,h,cpp}
	fi
}
