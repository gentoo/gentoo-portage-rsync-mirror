# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cdiff/cdiff-0.9.3.ebuild,v 1.1 2013/10/12 12:49:18 tomwij Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7,3_2} )
DOCS=( CHANGES README.rst )

inherit distutils-r1

DESCRIPTION="Colored, side-by-side diff terminal viewer."
HOMEPAGE="https://github.com/ymattw/${PN}"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

DEPEND="!app-misc/colordiff
	dev-python/setuptools[${PYTHON_USEDEP}]
	sys-apps/less"

RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/${PN}-0.9.2-disable-unimportant-failing-test.patch )

src_test() {
	python_export_best

	${PYTHON} tests/test_cdiff.py || die "Unit tests failed."

	./tests/regression.sh || die "Regression tests failed."
}