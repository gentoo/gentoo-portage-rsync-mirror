# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libssh/libssh-0.6.0.ebuild,v 1.4 2014/03/01 22:34:59 mgorny Exp $

EAPI=5

MY_P=${PN}-${PV/_rc/rc}
inherit eutils cmake-utils multilib

DESCRIPTION="Access a working SSH implementation by means of a library"
HOMEPAGE="http://www.libssh.org/"
SRC_URI="https://red.libssh.org/attachments/download/71/${MY_P}.tar.xz -> ${P}.tar.xz"

LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~arm ~hppa ~x86 ~amd64-linux ~x86-linux"
SLOT="0/4" # subslot = soname major version
IUSE="debug doc examples gcrypt gssapi pcap +sftp ssh1 server static-libs test zlib"
# Maintainer: check IUSE-defaults at DefineOptions.cmake

RDEPEND="
	zlib? ( >=sys-libs/zlib-1.2 )
	!gcrypt? ( >=dev-libs/openssl-0.9.8 )
	gcrypt? ( >=dev-libs/libgcrypt-1.5:0 )
	gssapi? ( virtual/krb5 )
"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	test? ( dev-util/cmocka )
"

DOCS=( AUTHORS README ChangeLog )

S=${WORKDIR}/${MY_P}

PATCHES=(
	"${FILESDIR}/${PN}-0.5.0-tests.patch"
	"${FILESDIR}/${PN}-0.6.0-libgcrypt-1.6.0.patch"
)

src_prepare() {
	# just install the examples do not compile them
	sed -i \
		-e '/add_subdirectory(examples)/s/^/#DONOTWANT/' \
		CMakeLists.txt || die

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with debug DEBUG_CALLTRACE)
		$(cmake-utils_use_with debug DEBUG_CRYPTO)
		$(cmake-utils_use_with gcrypt)
		$(cmake-utils_use_with gssapi)
		$(cmake-utils_use_with pcap)
		$(cmake-utils_use_with server)
		$(cmake-utils_use_with sftp)
		$(cmake-utils_use_with ssh1)
		$(cmake-utils_use_with static-libs STATIC_LIB)
		$(cmake-utils_use_with test STATIC_LIB)
		$(cmake-utils_use_with test TESTING)
		$(cmake-utils_use_with zlib)
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	use doc && cmake-utils_src_compile doc
}

src_install() {
	cmake-utils_src_install

	use doc && dohtml -r "${CMAKE_BUILD_DIR}"/doc/html/*

	use static-libs || rm -f "${D}"/usr/$(get_libdir)/libssh{,_threads}.a

	if use examples; then
		docinto examples
		dodoc examples/*.{c,h,cpp}
	fi
}
