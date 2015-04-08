# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cdiff/cdiff-9999.ebuild,v 1.4 2014/11/14 07:10:58 jlec Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} )

inherit distutils-r1

if [[ "${PV}" != *"9999"* ]] ; then
	KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
else
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/ymattw/cdiff.git"
	inherit git-r3
fi

DESCRIPTION="Colored, side-by-side diff terminal viewer"
HOMEPAGE="https://github.com/ymattw/${PN}"

LICENSE="BSD"
SLOT="0"

DEPEND="
	!<app-misc/colordiff-1.0.13-r1
	dev-python/setuptools[${PYTHON_USEDEP}]
	sys-apps/less"

RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/${PN}-0.9.2-disable-unimportant-failing-test.patch )

DOCS=( CHANGES.rst README.rst )

python_test() {
	python_export_best

	${PYTHON} tests/test_cdiff.py || die "Unit tests failed."

	./tests/regression.sh || die "Regression tests failed."
}
