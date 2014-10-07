# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/Fiona/Fiona-1.1.6.ebuild,v 1.1 2014/10/07 08:09:35 slis Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_3} )

inherit distutils-r1

DESCRIPTION="Fiona is OGR's neat, nimble, no-nonsense API"
HOMEPAGE="https://pypi.python.org/pypi/Fiona"

SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

LICENSE="BSD"
SLOT="1.1"
IUSE="test"

RDEPEND=">=sci-libs/gdal-1.8"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	test? ( dev-python/nose )
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )
	${PYTHON_DEPS}"

python_test() {
	esetup.py test
}