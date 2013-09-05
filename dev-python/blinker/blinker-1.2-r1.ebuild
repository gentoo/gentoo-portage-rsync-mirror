# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/blinker/blinker-1.2-r1.ebuild,v 1.3 2013/09/05 18:47:07 mgorny Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1

DESCRIPTION="Fast, simple object-to-object and broadcast signaling"
HOMEPAGE="http://discorporate.us/projects/Blinker/ http://pypi.python.org/pypi/blinker"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

DEPEND="test? ( dev-python/nose[${PYTHON_USEDEP}] )"

python_test() {
	nosetests || die "Testing failed with ${EPYTHON}"
}

python_install_all() {
	if use doc; then
		pushd docs/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static
		popd > /dev/null
	fi
}
