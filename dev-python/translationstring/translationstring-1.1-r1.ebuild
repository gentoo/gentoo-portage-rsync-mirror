# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/translationstring/translationstring-1.1-r1.ebuild,v 1.4 2014/03/31 21:13:30 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="Utility library for i18n relied on by various Repoze packages"
HOMEPAGE="https://github.com/Pylons/translationstring http://pypi.python.org/pypi/translationstring"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="repoze"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""

# Include COPYRIGHT.txt because the license seems to require it.
DOCS=( CHANGES.txt README.txt COPYRIGHT.txt )

python_test() {
	esetup.py test || die
}

src_install() {
	distutils-r1_src_install

	# Install only the .rst source, as sphinx processing requires a
	# theme only available from git that contains hardcoded references
	# to files on https://static.pylonsproject.org/ (so the docs would
	# not actually work offline). Install into a "docs" subdirectory
	# so the reference in the README remains correct.
	docinto docs
	docompress -x usr/share/doc/${PF}/docs
	dodoc docs/*.rst
}
