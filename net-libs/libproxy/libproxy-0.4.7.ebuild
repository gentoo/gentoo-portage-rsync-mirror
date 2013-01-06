# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libproxy/libproxy-0.4.7.ebuild,v 1.12 2012/10/16 08:04:33 tetromino Exp $

EAPI=4
PYTHON_DEPEND="python? 2:2.6"

inherit cmake-utils eutils mono python

DESCRIPTION="Library for automatic proxy configuration management"
HOMEPAGE="http://code.google.com/p/libproxy/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-linux"
IUSE="gnome kde mono networkmanager perl python test"

# FIXME: Disable webkit support due problems like bug #366791
# FIXME: Also disable xulrunner support due bug #360893, will be readded
# in the future when only spidermonkey mozjs is provided.
# NOTE: USE=xulrunner also causes problems like bug 373397, re-add carefully.

RDEPEND="gnome? ( >=dev-libs/glib-2.26:2 )
	kde? ( >=kde-base/kdelibs-4.4.5 )
	mono? ( dev-lang/mono )
	networkmanager? ( net-misc/networkmanager )
	perl? (	dev-lang/perl )"
#	xulrunner? ( >=net-libs/xulrunner-1.9.1:1.9 )
#	webkit? ( net-libs/webkit-gtk:2 )
# Since 0.4.7, webkit gtk3 support is also available
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"

	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	epatch "${FILESDIR}/${P}-gcc-4.7.patch"
}

src_configure() {
	# WITH_VALA just copies the .vapi file over and needs no deps,
	# hence always enable it unconditionally
	local mycmakeargs=(
			-DPERL_VENDORINSTALL=ON
			-DCMAKE_C_FLAGS="${CFLAGS}"
			-DCMAKE_CXX_FLAGS="${CXXFLAGS}"
			$(cmake-utils_use_with gnome GNOME)
			$(cmake-utils_use_with gnome GNOME3)
			$(cmake-utils_use_with kde KDE4)
			$(cmake-utils_use_with mono DOTNET)
			$(cmake-utils_use_with networkmanager NM)
			$(cmake-utils_use_with perl PERL)
			$(cmake-utils_use_with python PYTHON)
			-DWITH_VALA=ON
			-DWITH_WEBKIT=OFF
			-DWITH_WEBKIT3=OFF
			-DWITH_MOZJS=OFF
			$(cmake-utils_use test BUILD_TESTING)
	)
			#$(cmake-utils_use_with webkit WEBKIT)
			#$(cmake-utils_use_with xulrunner MOZJS)
	cmake-utils_src_configure
}

pkg_postinst() {
	use python && python_mod_optimize ${PN}.py
}

pkg_postrm() {
	use python && python_mod_cleanup ${PN}.py
}
