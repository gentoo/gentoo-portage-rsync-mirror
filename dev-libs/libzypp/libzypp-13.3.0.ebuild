# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libzypp/libzypp-13.3.0.ebuild,v 1.3 2013/08/02 05:26:44 miska Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="ZYpp Package Management library"
HOMEPAGE="http://doc.opensuse.org/projects/libzypp/HEAD/"
# version bumps check here:
#  https://build.opensuse.org/package/show/openSUSE:Factory/libzypp
SRC_URI="http://github.com/openSUSE/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc libproxy"

RDEPEND="
	app-arch/rpm
	dev-libs/boost
	dev-libs/expat
	dev-libs/libxml2
	dev-libs/openssl:0
	net-misc/curl
	sys-libs/zlib
	virtual/udev
	libproxy? ( net-libs/libproxy )
"
DEPEND="${DEPEND}
	dev-libs/libsolv
	sys-devel/gettext
	doc? ( app-doc/doxygen[dot] )
"

# tests require actual instance of zypp to be on system
RESTRICT="test"

src_prepare() {
	epatch \
		"${FILESDIR}/${PN}-fix-compilation.patch" \
		"${FILESDIR}/${PN}-fix-tests.patch"
}

src_configure() {
	local mycmakeargs=(
		"-DUSE_TRANSLATION_SET=zypp"
		$(cmake-utils_use_disable doc AUTODOCS)
		$(cmake-utils-use_disable libproxy LIBPROXY)
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	cmake-utils_src_compile -C po translations
}

src_test() {
	cmake-utils_src_compile -C tests
	cmake-utils_src_test
}

src_install() {
	cmake-utils_src_install
	cmake-utils_src_install -C po
}
