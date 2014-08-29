# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glfw/glfw-3.0.4.ebuild,v 1.1 2014/08/29 19:52:26 mr_bones_ Exp $

EAPI=5
inherit cmake-utils

DESCRIPTION="The Portable OpenGL FrameWork"
HOMEPAGE="http://www.glfw.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="egl examples"

RDEPEND="x11-libs/libXrandr
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXxf86vm
	virtual/opengl"
DEPEND="${RDEPEND}
	virtual/glu"

src_configure() {
	local mycmakeargs="
		$(cmake-utils_use egl GLFW_USE_EGL)
		$(cmake-utils_use examples GLFW_BUILD_EXAMPLES)
		-DBUILD_SHARED_LIBS=1
	"
	cmake-utils_src_configure
}
