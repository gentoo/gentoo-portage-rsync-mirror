# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/hgdistver/hgdistver-0.16-r1.ebuild,v 1.9 2014/06/08 11:08:24 hattya Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="utility lib to generate python package version infos from mercurial tags"
HOMEPAGE="http://bitbucket.org/RonnyPfannschmidt/hgdistver/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ~ia64 ~mips x86 ~x86-fbsd"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? ( dev-python/pytest[${PYTHON_USEDEP}] )"
RDEPEND=""

python_test() {
	# https://bitbucket.org/RonnyPfannschmidt/hgdistver/issue/9/test-failures; train wreck
	nosetests || die "Tests failed under ${EPYTHON}"
}
