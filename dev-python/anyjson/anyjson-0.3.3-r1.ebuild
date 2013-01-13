# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/anyjson/anyjson-0.3.3-r1.ebuild,v 1.1 2013/01/13 20:41:11 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7,3_1,3_2,3_3} pypy{1_9,2_0} )

inherit distutils-r1

DESCRIPTION="Wraps the best available JSON implementation available in a common interface"
HOMEPAGE="http://bitbucket.org/runeh/anyjson"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

# python2.6+ has builtin json module
# python2.5 needs any of the supported impls
RDEPEND="
	python_targets_python2_5? (
		dev-python/simplejson[python_targets_python2_5] )"

# please keep all supported implementations in 'test?'
# to make sure the package is used in the widest way
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/simplejson[$(python_gen_usedep python2* python3_3 pypy*)]
	)"

python_test() {
	cp -r -l tests "${BUILD_DIR}"/lib || die
	if [[ ${EPYTHON} == python3* ]]; then
		2to3 -w --no-diffs "${BUILD_DIR}"/lib || die
	fi

	nosetests -w "${BUILD_DIR}"/lib || die "Tests fail with ${EPYTHON}"
}
