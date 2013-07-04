# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/netcdf4-python/netcdf4-python-1.0.4.ebuild,v 1.2 2013/07/04 16:06:06 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

MY_PN="netCDF4"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python/numpy interface to netCDF"
HOMEPAGE="https://code.google.com/p/netcdf4-python"
SRC_URI="https://netcdf4-python.googlecode.com/files/${MY_P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="
	sci-libs/hdf5
	sci-libs/netcdf[hdf]"
DEPEND="${RDEPEND}
	test? ( virtual/python-unittest2 )"

S="${WORKDIR}"/${MY_P}

python_test() {
	cd test || die
	${PYTHON} run_all.py || die
}
