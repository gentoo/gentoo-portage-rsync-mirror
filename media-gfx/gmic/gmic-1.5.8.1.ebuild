# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gmic/gmic-1.5.8.1.ebuild,v 1.1 2013/12/18 10:55:50 radhermit Exp $

EAPI=5

inherit eutils toolchain-funcs bash-completion-r1 flag-o-matic

DESCRIPTION="GREYC's Magic Image Converter"
HOMEPAGE="http://gmic.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.tar.gz
	doc? ( http://dev.gentoo.org/~radhermit/dist/gmic_reference-${PV}.pdf.xz )"

LICENSE="CeCILL-2 FDL-1.3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc ffmpeg fftw graphicsmagick jpeg opencv openexr png tiff X zlib"

RDEPEND="
	ffmpeg? ( virtual/ffmpeg )
	fftw? ( sci-libs/fftw:3.0[threads] )
	graphicsmagick? ( media-gfx/graphicsmagick )
	jpeg? ( virtual/jpeg )
	opencv? ( >=media-libs/opencv-2.3.1a-r1 )
	openexr? (
		media-libs/ilmbase
		media-libs/openexr
	)
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )
	X? (
		x11-libs/libX11
		x11-libs/libXext
	)
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	doc? ( app-arch/xz-utils )"

S=${WORKDIR}/${P}/src

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.5.8.0-makefile.patch
	epatch "${FILESDIR}"/${PN}-1.5.2.2-ffmpeg.patch

	for i in ffmpeg fftw jpeg opencv png tiff zlib ; do
		use $i || { sed -i -r "s/^(${i}_(C|LD)FLAGS =).*/\1/I" Makefile || die ; }
	done

	use graphicsmagick || { sed -i -r "s/^(MAGICK_(C|LD)FLAGS =).*/\1/" Makefile || die ; }
	use openexr || { sed -i -r "s/^(EXR_(C|LD)FLAGS =).*/\1/" Makefile || die ; }

	if ! use X ; then
		sed -i -r "s/^((X11|XSHM)_(C|LD)FLAGS =).*/\1/" Makefile || die

		# disable display capabilities when X support is disabled
		append-cppflags -Dcimg_display=0
	fi
}

src_compile() {
	emake AR="$(tc-getAR)" CC="$(tc-getCXX)" CFLAGS="${CXXFLAGS}" custom lib
}

src_install() {
	dobin gmic
	newlib.so libgmic.so libgmic.so.1

	insinto /usr/include
	doins gmic.h

	doman ../man/gmic.1.gz
	dodoc ../README

	use doc && dodoc "${WORKDIR}"/gmic_reference-${PV}.pdf

	newbashcomp gmic_bashcompletion.sh ${PN}
}
