# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/deform/deform-0.9.8.ebuild,v 1.1 2013/09/02 06:49:59 patrick Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} python3_2 pypy{1_9,2_0} )
inherit distutils-r1

DESCRIPTION="Another form generation library"
HOMEPAGE="http://docs.pylonsproject.org/projects/deform/en/latest/ http://pypi.python.org/pypi/deform https://github.com/Pylons/deform"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="repoze"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
# tests require zope.deprecation
RESTRICT="test"

# Depend on peppercorn, translationstring and colander with Python 3 support
RDEPEND=">=dev-python/translationstring-1.1
	>=dev-python/colander-1.0_alpha1
	>=dev-python/peppercorn-0.4
	>=dev-python/chameleon-1.2.3"
DEPEND="${RDEPEND}
	test? ( dev-python/beautifulsoup:4 )"

# Include COPYRIGHT.txt because the license seems to require it.
DOCS=( CHANGES.txt COPYRIGHT.txt README.txt )

src_install() {
	distutils-r1_src_install

	# Install only the .rst source, as sphinx processing requires
	# a theme only available from git that contains hardcoded
	# references to files on https://static.pylonsproject.org/ (so
	# the docs would not actually work offline). Install the
	# source, which is somewhat readable.
	docinto docs
	dodoc docs/*.rst || die
}
