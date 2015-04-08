# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/xlwt/xlwt-0.7.5.ebuild,v 1.7 2014/03/31 20:57:39 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="Python library to create spreadsheet files compatible with Excel"
HOMEPAGE="http://pypi.python.org/pypi/xlwt"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="examples"

python_prepare_all() {
	# Don't install documentation and examples in site-packages directories.
	sed -e "/package_data/,+6d" -i setup.py || die

	distutils-r1_python_prepare_all
}

python_install_all() {
	local HTML_DOCS=( HISTORY.html xlwt/doc/xlwt.html )
	use examples && local EXAMPLES=( xlwt/examples )
	distutils-r1_python_install_all

	dodoc -r tests
	docompress -x /usr/share/doc/${PF}/tests
}
