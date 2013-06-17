# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rdflib/rdflib-4.0.1.ebuild,v 1.2 2013/06/17 13:50:19 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )
PYTHON_REQ_USE="sqlite?"
DISTUTILS_NO_PARALLEL_BUILD=true

inherit distutils-r1

DESCRIPTION="RDF library containing a triple store and parser/serializer"
HOMEPAGE="https://github.com/RDFLib/rdflib http://pypi.python.org/pypi/rdflib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="berkdb examples mysql redland sqlite test"

RDEPEND="
	dev-python/isodate[${PYTHON_USEDEP}]
	dev-python/html5lib[$(python_gen_usedep 'python2*')]
	virtual/pyparsing[${PYTHON_USEDEP}]
	berkdb? ( dev-python/bsddb3[${PYTHON_USEDEP}] )
	mysql? ( dev-python/mysql-python[$(python_gen_usedep 'python2*')] )
	redland? ( dev-libs/redland-bindings[python] )"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/sparql-wrapper[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}] )"

REQUIERED_USE="mysql? (-python_single_target_python3_3 -python_single_target_python3_2 -python_single_target_python3_1)"

python_prepare_all() {
	# Upstream manufactured .pyc files which promptly break distutils' src_test
	find -name "*.py[oc~]" -delete || die
	distutils-r1_python_prepare_all
}

python_test() {
	https://github.com/RDFLib/rdflib/issues/306
	PYTHONPATH=. nosetests --verbosity=3 --py3where='build/src' || die "Tests failed under ${EPYTHON}"
}

python_install_all() {
	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install_all
}
