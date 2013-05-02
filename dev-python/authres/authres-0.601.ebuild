# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/authres/authres-0.601.ebuild,v 1.1 2013/05/02 05:45:25 patrick Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} pypy{1_9,2_0} )

inherit distutils-r1

DESCRIPTION="Authentication Results Header Module"
HOMEPAGE="https://launchpad.net/authentication-results-python http://pypi.python.org/pypi/authres"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DOCS=( CHANGES README )

python_test() {
	"${PYTHON}" -c "import sys, ${PN}, doctest; f, t = doctest.testfile('${PN}/tests'); \
		sys.exit(bool(f))" || return
}
