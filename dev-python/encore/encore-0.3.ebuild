# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/encore/encore-0.3.ebuild,v 1.1 2013/04/05 14:19:00 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Enthought Tool Suite: collection of core-level utility modules"
HOMEPAGE="https://github.com/enthought/encore"
SRC_URI="http://www.enthought.com/repo/ets/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples test"

RDEPEND=""
DEPEND="doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( dev-python/futures[${PYTHON_USEDEP}] )"

DOCS="dataflow.txt"

python_prepare_all() {
	# use of port 8080 is highly prone to prior use on testing
	sed -e 's:self.port = 8080:self.port = 8020:' \
		 -i encore/storage/tests/static_url_store_test.py || die
}

python_compile_all() {
	use doc && PYTHONPATH="$(ls -1d ${S}/build*/lib | head -n1)" \
		emake -C docs html
}

python_test() {
	# as set for py2.6 in 0.2, likely due to tests coded to import only unittest
	[[ "${EPYTHON:6:3}" = '2.6' ]] && return
	nosetests || die
}

python_install_all() {
	find -name "*LICENSE*.txt" -delete
	use doc && dohtml -r docs/build/html/*

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
