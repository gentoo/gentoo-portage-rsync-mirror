# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/qrupdate/qrupdate-1.1.1.ebuild,v 1.7 2012/10/16 20:02:31 jlec Exp $

EAPI=4

inherit eutils fortran-2 multilib versionator toolchain-funcs

DESCRIPTION="Library for updating of QR and Cholesky decompositions"
HOMEPAGE="http://sourceforge.net/projects/qrupdate"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~ppc-macos ~amd64-linux"
IUSE="static-libs"

RDEPEND="virtual/lapack"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-Makefiles.patch
	sed -i Makeconf \
		-e "s:gfortran:$(tc-getFC):g" \
		-e "s:FFLAGS=.*:FFLAGS=${FFLAGS}:" \
		-e "s:BLAS=.*:BLAS=$(pkg-config --libs blas):" \
		-e "s:LAPACK=.*:LAPACK=$(pkg-config --libs lapack):" \
		-e "/^LIBDIR=/a\PREFIX=${EPREFIX}/usr" \
		-e "s:LIBDIR=lib:LIBDIR=$(get_libdir):" \
		|| die "Failed to set up Makeconf"
}

src_compile() {
	emake solib
	use static-libs && emake lib
}

src_install() {
	emake DESTDIR="${D}" install-shlib
	dosym libqrupdate.so.$(get_major_version) /usr/$(get_libdir)/libqrupdate.so
	use static-libs && emake DESTDIR="${D}" install-staticlib
	dodoc README ChangeLog
}
