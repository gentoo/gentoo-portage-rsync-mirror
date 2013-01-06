# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/mpi-dotnet/mpi-dotnet-1.0.0.ebuild,v 1.10 2012/06/25 18:38:03 jsbronder Exp $

WANT_AUTOTOOLS="2.5"
inherit autotools eutils mono

# "." is not allowed as part of a package name
MY_PN="mpi.net"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="C# bindings for various MPI-implementations"
HOMEPAGE="http://www.osl.iu.edu/research/mpi.net"
SRC_URI="http://www.osl.iu.edu/research/mpi.net/files/${PV}/${MY_P}.tar.gz"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="doc examples"

RDEPEND="virtual/mpi
		>=dev-lang/mono-2.0"
DEPEND="${RDEPEND}
		dev-lang/perl"

MPICC="${CC}"

# tests hang at one point
RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/configure.ac.patch"
	epatch "${FILESDIR}/Makefile.am.patch"
	epatch "${FILESDIR}/Unsafe.pl.patch"

	has_version '>=dev-lang/mono-2.8' && sed -ie 's:ilasm2:ilasm:' configure.ac

	# MPI/Makefile seems broken, fix it
	eautoreconf
}

src_compile() {
	# policy requires us to build shared and static libs alongside
	econf --enable-shared --enable-static
	emake
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"

	if use examples ; then
		insinto "/usr/share/doc/${PF}"
		doins -r Examples
	fi
	use doc && dodoc Documentation/MPI.NET\ Tutorial{,\ Python}.doc
}

src_test() {
	make check -k
}
