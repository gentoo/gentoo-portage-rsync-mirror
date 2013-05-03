# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mimeparse/mimeparse-0.1.4.ebuild,v 1.2 2013/05/03 01:08:58 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} pypy{1_9,2_0} )

inherit distutils-r1

DESCRIPTION="Basic functions for handling mime-types in python"
HOMEPAGE="http://code.google.com/p/mimeparse
	https://github.com/dbtsai/python-mimeparse"
MY_PN="python-${PN}"
MY_P="${MY_PN}-${PV}"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

python_test() {
	"${PYTHON}" mimeparse_test.py || die "Tests fail with ${EPYTHON}"
}
