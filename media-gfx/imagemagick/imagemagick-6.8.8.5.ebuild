# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/imagemagick/imagemagick-6.8.8.5.ebuild,v 1.6 2014/02/20 14:45:59 ago Exp $

EAPI=5
inherit multilib toolchain-funcs versionator libtool flag-o-matic eutils

MY_P=ImageMagick-$(replace_version_separator 3 '-')

DESCRIPTION="A collection of tools and libraries for many image formats"
HOMEPAGE="http://www.imagemagick.org/"
SRC_URI="mirror://${PN}/${MY_P}.tar.xz"

LICENSE="imagemagick"
SLOT="0/${PV}"
# KEYWORDS="~alpha ~ppc64 ~sparc ~amd64-fbsd" dropped because of missing KEYWORDS in app-text/mupdf wrt #491876
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="autotrace bzip2 corefonts cxx djvu fftw fontconfig fpx graphviz hdri jbig jpeg jpeg2k lcms lqr lzma opencl openexr openmp pango pdf perl png postscript q32 q64 q8 raw static-libs svg test tiff truetype webp wmf X xml zlib"

RESTRICT="perl? ( userpriv )"

RDEPEND=">=sys-devel/libtool-2.2.6b
	autotrace? ( >=media-gfx/autotrace-0.31.1 )
	bzip2? ( app-arch/bzip2 )
	corefonts? ( media-fonts/corefonts )
	djvu? ( app-text/djvu )
	fftw? ( sci-libs/fftw:3.0 )
	fontconfig? ( media-libs/fontconfig )
	fpx? ( >=media-libs/libfpx-1.3.0-r1 )
	graphviz? ( media-gfx/graphviz )
	jbig? ( media-libs/jbigkit )
	jpeg? ( virtual/jpeg:0 )
	jpeg2k? ( media-libs/openjpeg:2 )
	lcms? ( media-libs/lcms:2 )
	lqr? ( media-libs/liblqr )
	opencl? ( virtual/opencl )
	openexr? ( media-libs/openexr:0= )
	pango? ( x11-libs/pango )
	pdf? ( app-text/mupdf:0= )
	perl? ( >=dev-lang/perl-5.8.8:0= )
	png? ( media-libs/libpng:0= )
	postscript? ( app-text/ghostscript-gpl )
	raw? ( media-gfx/ufraw )
	svg? ( gnome-base/librsvg )
	tiff? ( media-libs/tiff:0 )
	truetype? (
		media-fonts/urw-fonts
		>=media-libs/freetype-2
		)
	webp? ( media-libs/libwebp:0= )
	wmf? ( media-libs/libwmf )
	X? (
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libXext
		x11-libs/libXt
		)
	xml? ( dev-libs/libxml2 )
	lzma? ( app-arch/xz-utils )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	!media-gfx/graphicsmagick[imagemagick]
	virtual/pkgconfig
	X? ( x11-proto/xextproto )"

REQUIRED_USE="corefonts? ( truetype )
	test? ( corefonts )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	elibtoolize # for Darwin modules

	# http://bugs.gentoo.org/472766
	shopt -s nullglob
	cards=$(echo -n /dev/dri/card* | sed 's/ /:/g')
	if test -n "${cards}"; then
		addpredict "${cards}"
	fi
	shopt -u nullglob
}

src_configure() {
	local depth=16
	use q8 && depth=8
	use q32 && depth=32
	use q64 && depth=64

	local openmp=disable
	use openmp && { tc-has-openmp && openmp=enable; }

	[[ ${CHOST} == *-solaris* ]] && append-ldflags -lnsl -lsocket

	econf \
		$(use_enable static-libs static) \
		$(use_enable hdri) \
		$(use_enable opencl) \
		--with-threads \
		--with-modules \
		--with-quantum-depth=${depth} \
		$(use_with cxx magick-plus-plus) \
		$(use_with perl) \
		--with-perl-options='INSTALLDIRS=vendor' \
		--with-gs-font-dir="${EPREFIX}"/usr/share/fonts/urw-fonts \
		$(use_with bzip2 bzlib) \
		$(use_with X x) \
		$(use_with zlib) \
		$(use_with autotrace) \
		$(use_with postscript dps) \
		$(use_with djvu) \
		--with-dejavu-font-dir="${EPREFIX}"/usr/share/fonts/dejavu \
		$(use_with fftw) \
		$(use_with fpx) \
		$(use_with fontconfig) \
		$(use_with truetype freetype) \
		$(use_with postscript gslib) \
		$(use_with graphviz gvc) \
		$(use_with jbig) \
		$(use_with jpeg) \
		$(use_with jpeg2k openjp2) \
		--without-lcms \
		$(use_with lcms lcms2) \
		$(use_with lqr) \
		$(use_with lzma) \
		$(use_with pdf mupdf) \
		$(use_with openexr) \
		$(use_with pango) \
		$(use_with png) \
		$(use_with svg rsvg) \
		$(use_with tiff) \
		$(use_with webp) \
		$(use_with corefonts windows-font-dir "${EPREFIX}"/usr/share/fonts/corefonts) \
		$(use_with wmf) \
		$(use_with xml) \
		--${openmp}-openmp
}

src_test() {
	if has_version ~${CATEGORY}/${P}; then
		emake -j1 check
	else
		ewarn "Skipping testsuite because installed version doesn't match."
	fi
}

src_install() {
	# Ensure documentation installation files and paths with each release!
	emake \
		DESTDIR="${D}" \
		DOCUMENTATION_PATH="${EPREFIX}"/usr/share/doc/${PF}/html \
		install

	rm -f "${ED}"/usr/share/doc/${PF}/html/{ChangeLog,LICENSE,NEWS.txt}
	dodoc {AUTHORS,README}.txt ChangeLog

	if use perl; then
		find "${ED}" -type f -name perllocal.pod -exec rm -f {} +
		find "${ED}" -depth -mindepth 1 -type d -empty -exec rm -rf {} +
	fi

	find "${ED}" -name '*.la' -exec sed -i -e "/^dependency_libs/s:=.*:='':" {} +
}
