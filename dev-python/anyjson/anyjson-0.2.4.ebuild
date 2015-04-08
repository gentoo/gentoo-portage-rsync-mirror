# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/anyjson/anyjson-0.2.4.ebuild,v 1.4 2014/03/31 20:50:55 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="Wraps the best available JSON implementation available in a common interface"
HOMEPAGE="http://bitbucket.org/runeh/anyjson"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

# please keep all supported implementations in 'test?'
# to make sure the package is used in the widest way
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/simplejson[$(python_gen_usedep 'python2*' python3_3 'pypy*')]
	)"

python_test() {
	cp -r -l tests "${BUILD_DIR}"/lib || die
	if [[ ${EPYTHON} == python3* ]]; then
		2to3 -w --no-diffs "${BUILD_DIR}"/lib || die
	fi

	nosetests -w "${BUILD_DIR}"/lib || die "Tests fail with ${EPYTHON}"
}
