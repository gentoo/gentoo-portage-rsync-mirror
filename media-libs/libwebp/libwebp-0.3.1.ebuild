# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libwebp/libwebp-0.3.1.ebuild,v 1.3 2013/08/06 06:13:56 jmorgan Exp $

EAPI=5
inherit eutils multilib-minimal

DESCRIPTION="A lossy image compression format"
HOMEPAGE="http://code.google.com/p/webp/"
SRC_URI="http://webp.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-fbsd ~amd64-linux ~x86-linux"
IUSE="experimental gif +jpeg opengl +png static-libs swap-16bit-csp tiff"

# TODO: dev-lang/swig bindings in swig/ subdirectory
RDEPEND="gif? ( media-libs/giflib:= )
	jpeg? ( virtual/jpeg:0= )
	opengl? (
		media-libs/freeglut
		virtual/opengl
		)
	png? ( media-libs/libpng:0= )
	tiff? ( media-libs/tiff:0= )"
DEPEND="${RDEPEND}"

ECONF_SOURCE=${S}

src_prepare() {
	# This is conflicting with `usex` later on, upstream is using ac_cv_ wrong
	# If modifying configure.ac, eautoreconf is required because of "Maintainer mode"
	sed -i -e '/unset ac_cv_header_GL_glut_h/d' configure || die
}

multilib_src_configure() {
	ac_cv_header_gif_lib_h=$(usex gif) \
	ac_cv_header_jpeglib_h=$(usex jpeg) \
	ac_cv_header_png_h=$(usex png) \
	ac_cv_header_GL_glut_h=$(usex opengl) \
	ac_cv_header_tiffio_h=$(usex tiff) \
		econf \
			$(use_enable static-libs static) \
			$(use_enable swap-16bit-csp) \
			$(use_enable experimental) \
			--enable-libwebpmux \
			--enable-libwebpdemux \
			--enable-libwebpdecoder
}

multilib_src_install() {
	emake DESTDIR="${D}" install
}

multilib_src_install_all() {
	prune_libtool_files
	dodoc AUTHORS ChangeLog doc/*.txt NEWS README{,.mux}
}
