# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/Babel/Babel-0.9.6-r1.ebuild,v 1.4 2013/09/05 18:46:16 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )
inherit distutils-r1

DESCRIPTION="A collection of tools for internationalizing Python applications"
HOMEPAGE="http://babel.edgewall.org/ http://pypi.python.org/pypi/Babel"
SRC_URI="http://ftp.edgewall.com/pub/babel/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

DEPEND="dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

HTML_DOCS=( doc/. )

python_prepare_all() {
	# Make the tests use implementation-specific datadir,
	# because they try to write in it.
	sed -e '/datadir =/s:os\.path\.dirname(__file__):os.environ["BUILD_DIR"]:' \
		-i babel/messages/tests/frontend.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	# Create implementation-specific datadir for tests.
	cp -R -l babel/messages/tests/data "${BUILD_DIR}"/ || die

	export BUILD_DIR
	esetup.py test
}
