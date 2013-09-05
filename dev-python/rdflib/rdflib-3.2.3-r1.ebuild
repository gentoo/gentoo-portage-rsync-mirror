# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rdflib/rdflib-3.2.3-r1.ebuild,v 1.2 2013/09/05 18:47:13 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )
PYTHON_USE_WITH="sqlite?"
DISTUTILS_NO_PARALLEL_BUILD=true

inherit distutils-r1

DESCRIPTION="RDF library containing a triple store and parser/serializer"
HOMEPAGE="https://github.com/RDFLib/rdflib http://pypi.python.org/pypi/rdflib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="berkdb examples mysql redland sqlite test"

RDEPEND="
	dev-python/isodate[${PYTHON_USEDEP}]
	berkdb? ( dev-python/bsddb3 )
	mysql? ( dev-python/mysql-python[$(python_gen_usedep 'python2*')] )
	redland? ( dev-libs/redland-bindings[python] )"
DEPEND="${RDEPEND}
	dev-python/setuptools"

REQUIERED_USE="mysql? (-python_single_target_python3_3 -python_single_target_python3_2 -python_single_target_python3_1)"

python_prepare_all() {
	# Upstream manufactured .pyc files which promptly break distutils' src_test
	find -name "*.py[oc~]" -delete || die
	distutils-r1_python_prepare_all
}

python_test() {
	nosetests --verbosity=3 --py3where='build/src' || die
}

python_install_all() {
	distutils-r1_python_install_all

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/*
	fi
}
