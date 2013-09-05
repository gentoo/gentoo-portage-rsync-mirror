# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/html5lib/html5lib-1.0_beta1.ebuild,v 1.3 2013/09/05 18:46:22 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )
PYTHON_REQ_USE="xml(+)"

inherit distutils-r1

MY_P=${PN}-${PV/_beta/b}
DESCRIPTION="HTML parser based on the HTML5 specification"
HOMEPAGE="https://github.com/html5lib/html5lib-python/ http://pypi.python.org/pypi/html5lib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="test"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

S=${WORKDIR}/${MY_P}

python_test() {
	nosetests || die "Tests fail with ${EPYTHON}"
}
