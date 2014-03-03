# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/Fiona/Fiona-1.1.2.ebuild,v 1.1 2014/03/03 07:15:54 slis Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_3} )

inherit distutils-r1

DESCRIPTION="Fiona is OGR's neat, nimble, no-nonsense API"
HOMEPAGE="https://pypi.python.org/pypi/Fiona"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="http://github.com/Toblerity/${PN}.git"
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD"
SLOT="0"
IUSE="test"

RDEPEND=">=sci-libs/gdal-1.8"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	virtual/python-argparse[${PYTHON_USEDEP}]
	test? ( dev-python/nose )
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )
	test? ( virtual/python-unittest2[${PYTHON_USEDEP}] )"

python_test() {
	esetup.py test
}