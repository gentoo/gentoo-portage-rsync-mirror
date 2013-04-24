# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/atpy/atpy-0.9.6-r1.ebuild,v 1.1 2013/04/24 22:45:29 bicatali Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="sqlite"

inherit distutils-r1

MYPN=ATpy
MYP="${MYPN}-${PV}"

DESCRIPTION="Astronomical tables support for Python"
HOMEPAGE="http://atpy.github.com"
SRC_URI="mirror://github/${PN}/${PN}/${MYP}.tar.gz"

DEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-python/asciitable[${PYTHON_USEDEP}]
	fits? ( virtual/pyfits[${PYTHON_USEDEP}] )
	hdf5? ( dev-python/h5py[${PYTHON_USEDEP}] )
	mysql? ( dev-python/mysql-python[${PYTHON_USEDEP}] )
	postgres? ( dev-db/pygresql )
	votable? ( virtual/pyvo[${PYTHON_USEDEP}] )"

IUSE="+fits hdf5 mysql postgres sqlite +votable"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="GPL-3"

S="${WORKDIR}/${MYP}"

python_test() {
	PYTHONPATH="${BUILD_DIR}/lib" "${EPYTHON}" test/unittests.py || die
}
