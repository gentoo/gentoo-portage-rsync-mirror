# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/stomper/stomper-0.2.7.ebuild,v 1.2 2014/02/24 00:36:59 phajdan.jr Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
# uuid module required.
RESTRICT_PYTHON_ABIS="2.4 3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="Transport neutral client implementation of the STOMP protocol"
HOMEPAGE="http://pypi.python.org/pypi/stomper"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc x86"
IUSE="examples"

DEPEND="dev-python/setuptools"
RDEPEND=""

src_install() {
	distutils_src_install

	delete_examples_and_tests() {
		rm -fr "${ED}$(python_get_sitedir)/${PN}/"{examples,tests}
	}
	python_execute_function -q delete_examples_and_tests

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins lib/stomper/examples/* || die "Installation of examples failed"
	fi
}
