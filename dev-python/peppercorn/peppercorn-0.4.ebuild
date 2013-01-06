# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/peppercorn/peppercorn-0.4.ebuild,v 1.1 2012/02/22 23:56:14 marienz Exp $

EAPI=3

SUPPORT_PYTHON_ABIS=1
PYTHON_DEPEND="2 3:3.2"
RESTRICT_PYTHON_ABIS="2.4 3.0 3.1"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="A library for converting a token stream into a data structure for use in web form posts"
HOMEPAGE="https://github.com/Pylons/peppercorn http://pypi.python.org/pypi/peppercorn"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="repoze"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

# Include COPYRIGHT.txt because the license seems to require it.
DOCS="CHANGES.txt README.txt COPYRIGHT.txt"

src_install() {
	distutils_src_install

	# Install only the .rst source, as sphinx processing requires a
	# theme only available from git that contains hardcoded references
	# to files on https://static.pylonsproject.org/ (so the docs would
	# not actually work offline). Install into a "docs" subdirectory
	# so the reference in the README remains correct.
	docinto docs
	dodoc docs/*.rst
}
