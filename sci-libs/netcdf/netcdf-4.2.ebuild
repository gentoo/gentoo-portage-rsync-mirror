# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/netcdf/netcdf-4.2.ebuild,v 1.3 2012/10/16 20:31:51 jlec Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="Scientific library and interface for array oriented data access"
HOMEPAGE="http://www.unidata.ucar.edu/software/netcdf/"
SRC_URI="ftp://ftp.unidata.ucar.edu/pub/netcdf/${P}.tar.gz"

LICENSE="UCAR-Unidata"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+dap doc hdf +hdf5 mpi static-libs szip tools"

RDEPEND="
	dap? ( net-misc/curl )
	hdf? ( sci-libs/hdf >=sci-libs/hdf5-1.8.8 )
	hdf5? ( >=sci-libs/hdf5-1.8.8[mpi=,szip=,zlib] )"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_configure() {
	myeconfargs=(
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
		--disable-examples
		$(use_enable dap)
		$(use_enable doc doxygen)
		$(use_enable hdf hdf4)
		$(use_enable hdf5 netcdf-4)
		$(use_enable tools utilities)
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
