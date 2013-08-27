# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/R/R-2.10.1.ebuild,v 1.20 2013/08/27 15:03:04 kensington Exp $

EAPI=2

inherit bash-completion-r1 eutils flag-o-matic fortran-2 multilib versionator

DESCRIPTION="Language and environment for statistical computing and graphics"
HOMEPAGE="http://www.r-project.org/"
SRC_URI="
	mirror://cran/src/base/R-2/${P}.tar.gz
	bash-completion? ( mirror://gentoo/R.bash_completion.bz2 )"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"

IUSE="bash-completion cairo doc java jpeg lapack minimal nls perl png readline threads tk X"

# common depends
CDEPEND="
	app-arch/bzip2
	app-text/ghostscript-gpl
	dev-libs/libpcre
	virtual/blas
	cairo? (
		x11-libs/cairo[X]
		>=x11-libs/pango-1.20[X] )
	jpeg? ( virtual/jpeg:0 )
	lapack? ( virtual/lapack )
	perl? ( dev-lang/perl )
	png? ( media-libs/libpng )
	readline? ( sys-libs/readline )
	tk? ( dev-lang/tk )
	X? ( x11-libs/libXmu x11-misc/xdg-utils )"

DEPEND="${CDEPEND}
	virtual/pkgconfig
	doc? (
			virtual/latex-base
			dev-texlive/texlive-fontsrecommended
		   )"

RDEPEND="${CDEPEND}
	app-arch/unzip
	app-arch/zip
	java? ( >=virtual/jre-1.5 )"

RESTRICT="minimal? ( test )"

R_DIR=/usr/$(get_libdir)/${PN}

pkg_setup() {
	fortran-2_pkg_setup
	filter-ldflags -Wl,-Bdirect -Bdirect
	# avoid using existing R installation
	unset R_HOME
}

src_prepare() {
	# fix packages.html for doc (bug #205103)
	# check in later versions if fixed
	sed -i \
		-e "s:../../library:../../../../$(get_libdir)/R/library:g" \
		src/library/tools/R/packageshtml.R \
		|| die "sed failed"

	# fix Rscript
	sed \
		-e "s:-DR_HOME='\"\$(rhome)\"':-DR_HOME='\"${R_DIR}\"':" \
		-i src/unix/Makefile.in || die "sed unix Makefile failed"

	# fix HTML links to manual (bug #273957)
	sed \
		-e 's:\.\./manual/:manual/:g' \
		-i $(grep -Flr ../manual/ doc) \
		|| die "sed for HTML links to manual failed"

	# Fix compability with zlib-1.2.5.1-r1 OF change
	has_version ">=sys-libs/zlib-1.2.5.1-r1" && \
		sed -i -e '1i#define OF(x) x' src/main/unzip.h

	# Missing include that was implicit before
	sed -i -e '1i#include <zlib.h>' src/main/dounzip.c || die

	# Don't try to access libpng internal structure
	sed -i -e 's:png_ptr->jmpbuf:png_jmpbuf(png_ptr):' src/modules/X11/rbitmap.c || die

	use lapack && \
		export LAPACK_LIBS="$($(tc-getPKG_CONFIG) --libs lapack)"

	if use X; then
		export R_BROWSER="$(type -p xdg-open)"
		export R_PDFVIEWER="$(type -p xdg-open)"
	fi
	use perl && \
		export PERL5LIB="${S}/share/perl:${PERL5LIB:+:}${PERL5LIB}"
}

src_configure() {
	econf \
		--disable-rpath \
		--enable-R-profiling \
		--enable-memory-profiling \
		--enable-R-shlib \
		--enable-linux-lfs \
		--with-system-zlib \
		--with-system-bzlib \
		--with-system-pcre \
		--with-blas="$($(tc-getPKG_CONFIG) --libs blas)" \
		--docdir=/usr/share/doc/${PF} \
		rdocdir=/usr/share/doc/${PF} \
		$(use_enable nls) \
		$(use_enable threads) \
		$(use_with lapack) \
		$(use_with tk tcltk) \
		$(use_with jpeg jpeglib) \
		$(use_with !minimal recommended-packages) \
		$(use_with png libpng) \
		$(use_with readline) \
		$(use_with cairo) \
		$(use_with X x)
}

src_compile(){
	emake || die "emake failed"
	RMATH_V=0.0.0
	emake -j1 -C src/nmath/standalone \
		libRmath_la_LDFLAGS=-Wl,-soname,libRmath.so.${RMATH_V} \
		|| die "emake math library failed"
	if use doc; then
		export VARTEXFONTS="${T}/fonts"
		emake info pdf || die "emake docs failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	if use doc; then
		emake DESTDIR="${D}" \
			install-info install-pdf || die "emake install docs failed"
		dosym /usr/share/doc/${PF}/manual /usr/share/doc/${PF}/html/manual
	fi

	# standalone math lib install (-j1 basically harmless)
	emake -j1 \
		-C src/nmath/standalone \
		DESTDIR="${D}" install \
		|| die "emake install math library failed"

	local mv=$(get_major_version ${RMATH_V})
	mv  "${D}"/usr/$(get_libdir)/libRmath.so \
		"${D}"/usr/$(get_libdir)/libRmath.so.${RMATH_V}
	dosym libRmath.so.${RMATH_V} /usr/$(get_libdir)/libRmath.so.${mv}
	dosym libRmath.so.${mv} /usr/$(get_libdir)/libRmath.so

	# env file
	cat > 99R <<-EOF
		LDPATH=${R_DIR}/lib
		R_HOME=${R_DIR}
	EOF
	doenvd 99R || die "doenvd failed"
	use bash-completion && dobashcomp "${WORKDIR}"/R.bash_completion
}

pkg_config() {
	if use java; then
		einfo "Re-initializing java paths for ${P}"
		R CMD javareconf
	fi
}
