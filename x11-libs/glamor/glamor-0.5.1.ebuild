# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/glamor/glamor-0.5.1.ebuild,v 1.9 2013/11/24 20:51:45 zorry Exp $

EAPI=5

XORG_DRI=always
XORG_EAUTORECONF=yes
XORG_MODULE=driver/
XORG_MODULE_REBUILD=yes
S=${WORKDIR}/${PN}-egl-${PV}

inherit xorg-2 toolchain-funcs

DESCRIPTION="OpenGL based 2D rendering acceleration library"
SRC_URI="${XORG_BASE_INDIVIDUAL_URI}/${XORG_MODULE}${PN}-egl-${PV}.tar.bz2"

KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="gles"

RDEPEND=">=x11-base/xorg-server-1.10
	media-libs/mesa[egl,gbm]
	gles? (
		|| ( media-libs/mesa[gles2] media-libs/mesa[gles] )
	)
	>=x11-libs/pixman-0.21.8"
DEPEND="${RDEPEND}"

src_configure() {
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable gles glamor-gles2)
	)
	xorg-2_src_configure
}

src_prepare() {
	sed -i 's/inst_LTLIBRARIES/lib_LTLIBRARIES/' src/Makefile.am || die
	xorg-2_src_prepare
	# fail to load grafic driver with hardened compiler #488906
	if gcc-specs-now ; then
		append-ldflags -Wl,-z,lazy
	fi
}
