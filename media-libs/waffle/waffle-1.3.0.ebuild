# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/waffle/waffle-1.3.0.ebuild,v 1.2 2013/12/28 11:29:05 vapier Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="Library that allows selection of GL API and of window system at runtime"
HOMEPAGE="http://people.freedesktop.org/~chadversary/waffle/"
SRC_URI="http://people.freedesktop.org/~chadversary/waffle/files/release/${P}/${P}.tar.xz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="doc egl gbm test wayland"

RDEPEND="
	media-libs/mesa[egl?,gbm?]
	virtual/opengl
	wayland? ( >=dev-libs/wayland-1.0 )
	gbm? ( virtual/udev )
	x11-libs/libX11
	x11-libs/libxcb"
DEPEND="${RDEPEND}
	x11-proto/xcb-proto
	doc? (
		dev-libs/libxslt
		app-text/docbook-xml-dtd:4.2
	)"

src_configure() {
	local mycmakeargs=(
		-Dwaffle_has_glx=ON
		-Dwaffle_build_examples=OFF
		$(cmake-utils_use doc waffle_build_manpages)
		$(cmake-utils_use egl waffle_has_x11_egl)
		$(cmake-utils_use gbm waffle_has_gbm)
		$(cmake-utils_use test waffle_build_tests)
		$(cmake-utils_use wayland waffle_has_wayland)
	)

	cmake-utils_src_configure
}

src_test() {
	emake -C "${CMAKE_BUILD_DIR}" check
}
