# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/colander/colander-0.9.7.ebuild,v 1.1 2012/04/08 19:33:43 floppym Exp $

EAPI=4

SUPPORT_PYTHON_ABIS=1
PYTHON_DEPEND="2:2.6 3:3.2"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.0 3.1"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="A simple schema-based serialization and deserialization library"
HOMEPAGE="http://docs.pylonsproject.org/projects/colander/en/latest/ http://pypi.python.org/pypi/colander"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

# MIT license is used by included (modified) iso8601.py code.
LICENSE="repoze MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Depend on an ebuild of translationstring with Python 3 support.
RDEPEND=">=dev-python/translationstring-1.1"

DEPEND="${RDEPEND}
	dev-python/setuptools"

# Include COPYRIGHT.txt because the license seems to require it.
DOCS="CHANGES.txt COPYRIGHT.txt README.txt"

src_install() {
	distutils_src_install

	# The docs do not currently build for me and depend on a theme
	# only available from git that contains hardcoded references
	# to files on https://static.pylonsproject.org/ (so the docs
	# would not actually work offline). Include the source, which
	# is at least somewhat readable.

	docinto docs
	dodoc docs/*.rst
}
