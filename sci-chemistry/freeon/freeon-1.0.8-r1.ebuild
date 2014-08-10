# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/freeon/freeon-1.0.8-r1.ebuild,v 1.2 2014/08/10 20:28:32 slyfox Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=1
FORTRAN_STANDARD=90
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit autotools-utils fortran-2 python-any-r1

DESCRIPTION="An experimental suite of programs for linear scaling quantum chemistry"
HOMEPAGE="http://www.freeon.org"
SRC_URI="http://download.savannah.gnu.org/releases/${PN}/${PN}-${PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	sci-libs/hdf5
	virtual/blas
	virtual/lapack"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}"
