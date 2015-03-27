# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/Fiona/Fiona-1.4.1.ebuild,v 1.3 2015/03/27 21:09:18 slis Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Fiona is OGR's neat, nimble, no-nonsense API"
HOMEPAGE="https://pypi.python.org/pypi/Fiona"

SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

LICENSE="BSD"
SLOT=0
IUSE="test"

RDEPEND=">=sci-libs/gdal-1.8
	dev-python/click"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	test? ( dev-python/nose )
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )
	${PYTHON_DEPS}"

src_prepare() {
	epatch "${FILESDIR}/scriptname.patch"
}

python_test() {
	esetup.py test
}
