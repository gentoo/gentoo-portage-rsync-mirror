# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/html5lib/html5lib-0.90.ebuild,v 1.6 2012/08/02 21:59:05 neurogeek Exp $

EAPI="4"
PYTHON_DEPEND="2"
PYTHON_USE_WITH="xml(+)"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="HTML parser based on the HTML5 specification"
HOMEPAGE="http://code.google.com/p/html5lib/ http://pypi.python.org/pypi/html5lib"
SRC_URI="http://${PN}.googlecode.com/files/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86 ~x86-fbsd"
IUSE="examples"

DEPEND="app-arch/unzip
	dev-python/setuptools"
RDEPEND=""

src_install() {
	distutils_src_install

	if use examples ; then
		find examples -name "*.pyc" | xargs rm -fr
		insinto "/usr/share/doc/${PF}"
		doins -r examples || die "Installation of examples failed"
	fi
}
