# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glfw/glfw-3.0.3.ebuild,v 1.1 2013/11/05 15:48:21 chithanh Exp $

EAPI=5
inherit cmake-utils

DESCRIPTION="The Portable OpenGL FrameWork"
HOMEPAGE="http://glfw.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="egl examples"

DEPEND="x11-libs/libXrandr
	virtual/glu
	virtual/opengl"

src_configure() {
	local mycmakeargs="
		$(cmake-utils_use egl GLFW_USE_EGL)
		$(cmake-utils_use examples GLFW_BUILD_EXAMPLES)
		-DBUILD_SHARED_LIBS=1
	"
	cmake-utils_src_configure
}
