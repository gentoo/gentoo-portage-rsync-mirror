# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/tornado/tornado-2.4.ebuild,v 1.4 2014/08/13 18:24:16 blueness Exp $

EAPI="3"
PYTHON_DEPEND="2 3:3.2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.1 *-jython"

inherit distutils

DESCRIPTION="Scalable, non-blocking web server and tools"
HOMEPAGE="http://www.tornadoweb.org/ http://pypi.python.org/pypi/tornado"
SRC_URI="http://github.com/downloads/facebook/tornado/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="curl"

RDEPEND="curl? ( dev-python/pycurl )
	|| ( dev-lang/python:3.2 dev-lang/python:2.7 dev-lang/python:2.6 dev-python/simplejson )"
DEPEND="${RDEPEND}
	dev-python/setuptools"

src_test() {
	testing() {
		cd build-${PYTHON_ABI}/lib* || die
		PYTHONPATH="." "$(PYTHON)" tornado/test/runtests.py
	}
	python_execute_function testing
}
