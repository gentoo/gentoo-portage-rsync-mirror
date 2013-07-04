# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/netcdf4-python/netcdf4-python-1.0.4.ebuild,v 1.1 2013/07/04 15:57:45 jlec Exp $

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
IUSE=""

RDEPEND="sci-libs/netcdf"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${MY_P}
