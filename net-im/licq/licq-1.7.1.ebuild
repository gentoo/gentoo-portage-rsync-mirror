# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/licq/licq-1.7.1.ebuild,v 1.1 2013/04/16 14:51:03 polynomial-c Exp $

EAPI="5"

inherit cmake-utils eutils flag-o-matic

DESCRIPTION="ICQ Client with v8 support"
HOMEPAGE="http://www.licq.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc linguas_he nls socks5 ssl xosd aosd jabber qt4 msn ncurses"

RDEPEND=">=app-crypt/gpgme-1
	jabber? ( net-libs/gloox )
	qt4? ( dev-qt/qtgui:4 )
	ssl? ( >=dev-libs/openssl-0.9.5a )
	ncurses? (
		sys-libs/ncurses
		dev-libs/cdk
	)
	xosd? ( x11-libs/xosd )
	aosd? ( x11-libs/libaosd )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	nls? ( sys-devel/gettext )
	dev-libs/boost"

src_prepare() {
	#epatch "${FILESDIR}"/${PN}-1.5.1-find-libcdk.patch

	local licq_plugins="auto-reply rms"
	use ncurses && licq_plugins+=" console"
	use msn && licq_plugins+=" msn"
	use xosd && licq_plugins+=" osd"
	use aosd && licq_plugins+=" aosd"
	use jabber && licq_plugins+=" jabber"
	use qt4 && licq_plugins+=" qt4-gui"

	local plugins="" x
	for x in ${licq_plugins}; do
		plugins+=" ${x}\/CMakeLists.txt"
	done

	sed -i -e "s/file(GLOB cmake_plugins.*$/set(cmake_plugins ${plugins})/" plugins/CMakeLists.txt
}

pkg_setup() {
	# crutch
	append-flags -pthread
}

src_configure() {
	local myopts="-DCMAKE_BUILD_TYPE=$(use debug && echo 'Debug' || echo 'Release')"
	mycmakeargs="$myopts
		$(cmake-utils_use linguas_he USE_HEBREW)
		$(cmake-utils_use socks5 USE_SOCKS5)
		$(cmake-utils_use ssl USE_OPENSSL)
		$(cmake-utils_use nls ENABLE_NLS)
		-DUSE_FIFO=ON
		-DBUILD_PLUGINS=ON"

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc README

	docinto doc
	dodoc doc/*

	use ssl && dodoc README.OPENSSL

	exeinto /usr/share/${PN}/upgrade
	doexe upgrade/*.pl || die
}
