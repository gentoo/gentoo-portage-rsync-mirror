# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libzypp/libzypp-14.29.4.ebuild,v 1.1 2014/10/09 09:08:24 jlec Exp $

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
	dev-libs/popt
	>=dev-libs/libsolv-0.6.5
	dev-libs/openssl:0
	net-misc/curl
	sys-libs/zlib
	virtual/udev
	libproxy? ( net-libs/libproxy )
"
DEPEND="${DEPEND}
	sys-devel/gettext
	doc? ( app-doc/doxygen[dot] )
"

# tests require actual instance of zypp to be on system
RESTRICT="test"

PATCHES=( "${FILESDIR}"/${P}-overload.patch )

src_configure() {
	local mycmakeargs=(
		"-DUSE_TRANSLATION_SET=zypp"
		$(cmake-utils_useno doc DISABLE_AUTODOCS)
		$(cmake-utils_useno libproxy DISABLE_LIBPROXY)
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
