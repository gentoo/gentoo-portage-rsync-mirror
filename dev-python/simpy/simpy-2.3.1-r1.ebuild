# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/simpy/simpy-2.3.1-r1.ebuild,v 1.1 2013/06/04 11:48:33 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="tk"

inherit distutils-r1

MY_P="${P/simpy/SimPy}"

DESCRIPTION="Simulation in Python is an object-oriented, process-based discrete-event simulation language"
HOMEPAGE="http://simpy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}/SimPy-2.3/${MY_P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc test"

RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

python_test() {
	${PYTHON} -c "import SimPy; SimPy.test()" || die
}

python_install_all() {
	DOCS=( AUTHORS.txt CHANGES.txt README.txt )
	if use doc; then
		pushd docs > /dev/null || die
		PYTHONPATH=.. emake html && HTML_DOCS=( docs/html/. docs/build/doctrees/. )
		popd > /dev/null || die
	fi

	distutils-r1_python_install_all
}
