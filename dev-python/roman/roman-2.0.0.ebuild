# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/roman/roman-2.0.0.ebuild,v 1.5 2015/03/08 23:58:18 pacho Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="An Integer to Roman numerals converter"
HOMEPAGE="http://pypi.python.org/pypi/roman/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND="!<dev-python/docutils-0.9[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	app-arch/unzip"

python_test() {
	cp "${S}/src/tests.py" . || die "copying test file failed"
	esetup.py test
}
