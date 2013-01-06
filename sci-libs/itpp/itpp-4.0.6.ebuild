# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/itpp/itpp-4.0.6.ebuild,v 1.11 2012/07/06 07:45:01 jlec Exp $

inherit eutils flag-o-matic

DESCRIPTION="C++ library of mathematical, signal processing and communication"
HOMEPAGE="http://itpp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="blas debug doc fftw lapack minimal"

RDEPEND="
	!minimal? ( fftw? ( >=sci-libs/fftw-3.0.0 ) )
	blas? (
		virtual/blas
		lapack? ( virtual/lapack ) )"
DEPEND="${RDEPEND}
	doc? (
		app-doc/doxygen
		virtual/latex-base )"

# we need this to prevent itpp's specialized debug lib
# (built with USE="debug" set) from being stripped
RESTRICT="strip"

pkg_setup() {
	# lapack can only be used in conjunction with blas
	if use lapack && ! use blas; then
		die "USE=lapack requires USE=blas to be set"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc44.patch
}

src_compile() {
	# turn off performance critical debug code
	append-flags -DNDEBUG

	# make sure that -g is stripped always since we use
	# RESTRICT=strip. If debug info is needed please enable
	# the debug use flag and link against the debug *.so
	filter-flags -g

	local blas_conf="--without-blas"
	local lapack_conf="--without-lapack"
	if use blas; then
		if use lapack; then
			blas_conf="--with-blas=$(pkg-config lapack --libs)"
			lapack_conf="--with-lapack"
		else
			blas_conf="--with-blas=$(pkg-config blas --libs)"
		fi
	fi

	local fftw_conf="--without-fft";
	if use fftw;
	then
		fftw_conf="--with-fft=-lfftw3"
	fi

	local myconf="--docdir=/usr/share/doc/${P}"
	if use minimal; then
		myconf="${myconf} --disable-comm --disable-fixed --disable-optim --disable-protocol --disable-signal --disable-srccode"
	fi

	econf $(use_enable doc html-doc) \
		$(use_enable debug) \
		"${blas_conf}" \
		"${lapack_conf}" \
		"${fftw_conf}" \
		${myconf}
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog ChangeLog-2007 ChangeLog-2006 \
		ChangeLog-2005 INSTALL NEWS NEWS-3.10 NEWS-3.99 README TODO \
		|| die "failed to install docs"
}
