# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/greycstoration/greycstoration-2.9.ebuild,v 1.4 2010/11/08 18:05:28 ssuominen Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="Image regularization algorithm for denoising, inpainting and resizing"
HOMEPAGE="http://www.greyc.ensicaen.fr/~dtschump/greycstoration/"
SRC_URI="mirror://sourceforge/cimg/GREYCstoration-${PV}.zip"

LICENSE="CeCILL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fftw imagemagick jpeg lapack png tiff"

RDEPEND="fftw? ( >=sci-libs/fftw-3 )
	imagemagick? ( media-gfx/imagemagick )
	jpeg? ( virtual/jpeg )
	lapack? ( virtual/lapack )
	png? ( >=media-libs/libpng-1.4 )
	tiff? ( media-libs/tiff )
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrandr"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/GREYCstoration-${PV}/src

src_prepare() {
	epatch "${FILESDIR}"/${P}-libpng14.patch

	sed -i \
		-e "s:../CImg.h:CImg.h:" \
		greycstoration.cpp || die
}

src_compile() {
	local myconf="-Dcimg_use_xshm -Dcimg_use_xrandr -lX11 -lXext -lXrandr"

	use png && myconf+=" -Dcimg_use_png -lpng -lz"
	use jpeg && myconf+=" -Dcimg_use_jpeg -ljpeg"
	use tiff && myconf+=" -Dcimg_use_tiff -ltiff"
	use imagemagick && myconf+=" -Dcimg_use_magick $(Magick++-config --cppflags)
		$(Magick++-config --libs)"
	use fftw && myconf+=" -Dcimg_use_fftw3 -lfftw3"
	use lapack && myconf+=" -Dcimg_use_lapack -llapack"

	$(tc-getCXX) ${LDFLAGS} ${CXXFLAGS} -fno-tree-pre \
		-o greycstoration greycstoration.cpp \
		${myconf} -lm -lpthread || die
}

src_install() {
	dobin greycstoration || die
}
