# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cholmod/cholmod-1.7.4.ebuild,v 1.7 2012/10/15 22:45:52 naota Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=yes

inherit autotools-utils eutils

MY_PN=CHOLMOD
PPV=1.7.0

DESCRIPTION="Sparse Cholesky factorization and update/downdate library"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/cholmod/"
SRC_URI="
	http://www.cise.ufl.edu/research/sparse/${PN}/${MY_PN}-${PV}.tar.gz
	mirror://gentoo/${PN}-${PPV}-autotools.patch.bz2"

LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE="debug doc metis minimal static-libs +supernodal"

RDEPEND="
	sci-libs/amd
	sci-libs/colamd
	metis? (
		sci-libs/camd
		sci-libs/ccolamd
		|| ( sci-libs/metis sci-libs/parmetis ) )
	supernodal? ( virtual/lapack )"

DEPEND="${RDEPEND}
	supernodal? ( virtual/pkgconfig )
	metis? ( virtual/pkgconfig )"

DOCS=( README.txt Doc/ChangeLog )

S="${WORKDIR}/${MY_PN}"

src_prepare() {
	cd "${WORKDIR}"
	epatch "${WORKDIR}"/${PN}-${PPV}-autotools.patch
	cd "${S}"
	use debug && epatch "${FILESDIR}"/${P}-debug.patch
	# bug #399483 does not build with parmetis-3.2
	has_version "=sci-libs/parmetis-3.2*" && \
		epatch "${FILESDIR}"/${P}-parmetis32.patch

	# We need to take care of cholmod.h here as well depending on
	# the USE flags, otherwise the installed file will reference
	# headers that we may not have included.
	if use minimal; then
		sed -i '/^#define CHOLMOD_/{N;
		s:\(#define\) \(CHOLMOD_CONFIG_H\)\n:\1 \2\n\1 NMODIFY 1\n\1 NMATRIXOPS 1\n:}' \
		Include/cholmod_config.h
	fi

	if ! use supernodal; then
		sed -i '/^#define CHOLMOD_/{N;
		s:\(#define\) \(CHOLMOD_CONFIG_H\)\n:\1 \2\n\1 NSUPERNODAL 1\n:}' \
		Include/cholmod_config.h
	fi

	if ! use metis; then
		sed -i '/^#define CHOLMOD_/{N;
		s:\(#define\) \(CHOLMOD_CONFIG_H\)\n:\1 \2\n\1 NPARTITION 1\n:}' \
		Include/cholmod_config.h
	fi
	autotools-utils_src_prepare
}

src_configure() {
	local lapack_libs=no
	local blas_libs=no
	if use supernodal; then
		blas_libs=$(pkg-config --libs blas)
		lapack_libs=$(pkg-config --libs lapack)
	fi
	local myeconfargs+=(
		--with-blas="${blas_libs}"
		--with-lapack="${lapack_libs}"
		$(use_enable supernodal mod-supernodal)
		$(use_enable !minimal mod-modify)
		$(use_enable !minimal mod-matrixops)
		$(use_enable metis mod-partition)
	)
	autotools-utils_src_configure
}

src_test() {
	if ! use supernodal || ! use metis || use minimal; then
		ewarn "According to your useflags, some modules were not built on"
		ewarn "purpose. This can cause the tests included with Cholmod"
		ewarn "to fail. Rebuild with USE=\"supernodal metis -minimal\""
		ewarn "if you care."
	fi
	autotools-utils_src_test -C Demo test
}

src_install() {
	autotools-utils_src_install
	use doc && dodoc Doc/UserGuide.pdf
}
