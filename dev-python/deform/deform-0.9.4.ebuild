# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/deform/deform-0.9.4.ebuild,v 1.1 2012/02/23 00:31:45 marienz Exp $

EAPI="3"

SUPPORT_PYTHON_ABIS=1
PYTHON_DEPEND="2:2.6 3:3.2"
RESTRICT_PYTHON_ABIS="2.5 3.0 3.1"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="Another form generation library"
HOMEPAGE="http://docs.pylonsproject.org/projects/deform/en/latest/ http://pypi.python.org/pypi/deform https://github.com/Pylons/deform"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="repoze"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Depend on peppercorn, translationstring and colander with Python 3 support
RDEPEND=">=dev-python/translationstring-1.1
	>=dev-python/colander-0.9.6
	>=dev-python/peppercorn-0.4
	>=dev-python/chameleon-1.2.3"

# The tests depend on beautifulsoup4, which is not currently packaged.
# They will pass because setuptools downloads it from crummy.com
# during the test phase. This is undesirable, so restrict the tests for now.
# Revisit this in the future if beautifulsoup4 is packaged.
DEPEND="${RDEPEND}"
#	test? ( dev-python/beautifulsoup )"
RESTRICT="test"

# Include COPYRIGHT.txt because the license seems to require it.
DOCS="CHANGES.txt COPYRIGHT.txt README.txt"

src_install() {
	distutils_src_install

	# Install only the .rst source, as sphinx processing requires
	# a theme only available from git that contains hardcoded
	# references to files on https://static.pylonsproject.org/ (so
	# the docs would not actually work offline). Install the
	# source, which is somewhat readable.
	docinto docs
	dodoc docs/*.rst
}
