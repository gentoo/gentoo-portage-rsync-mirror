# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/gerris/gerris-20111123.ebuild,v 1.2 2012/05/04 08:22:51 jdhore Exp $

EAPI=4

inherit autotools eutils flag-o-matic

DESCRIPTION="Gerris Flow Solver"
HOMEPAGE="http://gfs.sourceforge.net/"
SRC_URI="http://dev.gentoo.org/~bicatali/distfiles/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples mpi static-libs"

# all these deps could be optional
# but the configure.in would have to be modified
# heavily for the automagic
RDEPEND="dev-libs/glib:2
	dev-games/ode
	sci-libs/netcdf
	sci-libs/gsl
	sci-libs/gts
	sci-libs/hypre
	sci-libs/lis
	sci-libs/proj
	>=sci-libs/fftw-3
	virtual/lapack
	mpi? ( virtual/mpi )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

# test assume it is installed
#RESTRICT="test"

S="${WORKDIR}"/${P/-20/-snapshot-}

src_prepare() {
	epatch "${FILESDIR}"/${P}-autotools.patch
	eautoreconf
}

src_configure() {
	append-cppflags "-I${EPREFIX}/usr/include/hypre"
	econf \
		$(use_enable mpi) \
		$(use_enable static-libs static) \
		LAPACK_LIBS="$(pkg-config --libs lapack)"
}

src_install() {
	default
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		rm -f doc/examples/*.pyc || die "Failed to remove python object"
		doins -r doc/examples/*
	fi
}
