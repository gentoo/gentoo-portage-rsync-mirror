# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/xlwt/xlwt-0.7.4.ebuild,v 1.2 2012/12/03 21:24:39 bicatali Exp $

EAPI=4
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python library to create spreadsheet files compatible with Excel"
HOMEPAGE="http://pypi.python.org/pypi/xlwt"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="examples"

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

src_prepare() {
	distutils_src_prepare

	# Don't install documentation and examples in site-packages directories.
	sed -e "/package_data/,+6d" -i setup.py || die "sed failed"
}

src_install() {
	distutils_src_install

	insinto /usr/share/doc/${PF}
	doins -r HISTORY.html xlwt/doc/xlwt.html tests
	use examples && doins -r xlwt/examples
}
