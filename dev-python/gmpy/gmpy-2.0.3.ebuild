# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gmpy/gmpy-2.0.3.ebuild,v 1.1 2013/12/23 12:55:20 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

MY_PN="${PN}2"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python bindings for GMP library"
HOMEPAGE="http://www.aleax.it/gmpy.html http://code.google.com/p/gmpy/ http://pypi.python.org/pypi/gmpy2"
SRC_URI="http://gmpy.googlecode.com/files/${MY_P}.zip"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="~amd64 ~x86 ~x86-linux ~ppc-macos"
IUSE="mpir"

RDEPEND="
	>=dev-libs/mpc-1.0.0
	>=dev-libs/mpfr-3.1.0
	!mpir? ( dev-libs/gmp )
	mpir? ( sci-libs/mpir )"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}"/${MY_P}

python_configure_all() {
	mydistutilsargs=(
		$(usex mpir --mpir --gmp)
		)
}

python_test() {
	cd test || die
	${PYTHON} runtests.py || die
}
