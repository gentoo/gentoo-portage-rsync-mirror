# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/munkres/munkres-1.0.5.4-r2.ebuild,v 1.2 2013/06/08 15:08:53 sochotnicky Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Module implementing munkres algorithm for the Assignment Problem"
HOMEPAGE="http://pypi.python.org/pypi/munkres/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test doc"

python_test() {
	"${PYTHON}" "${PN}.py" || die
}

src_install() {
	distutils-r1_src_install
	use doc && dohtml -r html/
}
