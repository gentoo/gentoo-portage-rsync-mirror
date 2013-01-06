# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cherryflow/cherryflow-5.ebuild,v 1.8 2010/07/14 17:12:47 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="CherryFlow is a continuations framework for working with CherryPy"
HOMEPAGE="http://subway.python-hosting.com/wiki/CherryFlow"
SRC_URI="http://gentooexperimental.org/~pythonhead/dist/${P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}"

src_install() {
	distutils_src_install

	insinto /usr/share/doc/${PF}
	doins devworksexample.py example.py wikiexample.py
}
