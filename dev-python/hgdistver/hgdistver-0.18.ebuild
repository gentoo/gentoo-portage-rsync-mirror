# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/hgdistver/hgdistver-0.18.ebuild,v 1.1 2014/06/23 02:36:02 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="utility lib to generate python package version infos from mercurial tags"
HOMEPAGE="http://bitbucket.org/RonnyPfannschmidt/hgdistver/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~mips ~x86 ~x86-fbsd"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? ( dev-python/pytest[${PYTHON_USEDEP}] )"
RDEPEND=""

python_test() {
	py.test || die "Tests failed under ${EPYTHON}"
}
