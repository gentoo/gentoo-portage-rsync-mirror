# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gdmodule/gdmodule-0.56-r2.ebuild,v 1.5 2012/08/02 18:04:39 bicatali Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-* *-jython"
DISTUTILS_SETUP_FILES=("Setup.py")

inherit distutils eutils flag-o-matic

DESCRIPTION="Python extensions for gd"
HOMEPAGE="http://newcenturycomputers.net/projects/gdmodule.html"
SRC_URI="http://newcenturycomputers.net/projects/download.cgi/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~ppc-macos ~x86-linux"
IUSE="jpeg png truetype xpm"

RDEPEND="
	media-libs/gd[jpeg?,png?,truetype?,xpm?]
	media-libs/giflib
	jpeg? ( virtual/jpeg )
	png? ( media-libs/libpng )
	truetype? ( media-libs/freetype:2 )
	xpm? ( x11-libs/libXpm )"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-fix-libs.patch

	# append unconditionally because it is enabled id media-libs/gd by default
	append-cppflags -DHAVE_LIBGIF

	use jpeg && append-cppflags -DHAVE_LIBJPEG
	use png && append-cppflags -DHAVE_LIBPNG
	use truetype && append-cppflags -DHAVE_LIBFREETYPE
	use xpm && append-cppflags -DHAVE_LIBXPM

	distutils_src_prepare
}
