# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/msieve/msieve-9999.ebuild,v 1.1 2013/01/06 14:20:34 patrick Exp $

EAPI=4
DESCRIPTION="A C library implementing a suite of algorithms to factor large integers"
HOMEPAGE="http://sourceforge.net/projects/msieve/"
#SRC_URI="mirror://sourceforge/${PN}/${PN}/Msieve%20v${PV}/${PN}${PV/./}src.tar.gz"
ESVN_REPO_URI="https://msieve.svn.sourceforge.net/svnroot/msieve"

inherit eutils subversion

LICENSE="public-domain"
SLOT="0"
KEYWORDS=""
IUSE="zlib +ecm mpi"

# some linking troubles with gwnum
DEPEND="ecm? ( sci-mathematics/gmp-ecm[-gwnum] )
	mpi? ( virtual/mpi )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"

src_prepare() {
	cd trunk
	# TODO: Integrate ggnfs properly
	sed -i -e 's/-march=k8//' Makefile 		|| die
	sed -i -e 's/CC =/#CC =/' Makefile 		|| die
	sed -i -e 's/CFLAGS =/CFLAGS +=/' Makefile 	|| die
}

src_compile() {
	cd trunk
	if use ecm; then
		export "ECM=1"
	fi
	if use mpi; then
		export "MPI=1"
	fi
	if use zlib; then
		export "ZLIB=1"
	fi
	emake all || die "Failed to build"
}

src_install() {
	cd trunk
	mkdir -p "${D}/usr/include/msieve"
	mkdir -p "${D}/usr/lib/"
	mkdir -p "${D}/usr/share/doc/${P}/"
	cp include/* "${D}/usr/include/msieve" || die "Failed to install"
	cp libmsieve.a "${D}/usr/lib/" || die "Failed to install"
	dobin msieve || die "Failed to install"
	cp Readme* "${D}/usr/share/doc/${P}/" || die "Failed to install"
}
