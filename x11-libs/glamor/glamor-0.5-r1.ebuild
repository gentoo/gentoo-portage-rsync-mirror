# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/glamor/glamor-0.5-r1.ebuild,v 1.1 2013/03/12 16:43:56 chithanh Exp $

EAPI=5

XORG_DRI=always
XORG_EAUTORECONF=yes
XORG_MODULE_REBUILD=yes

inherit xorg-2

DESCRIPTION="OpenGL based 2D rendering acceleration library"
SRC_URI="mirror://gentoo/${P}.tar.gz"

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
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
}
