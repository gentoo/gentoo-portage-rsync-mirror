# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/jsonpickle/jsonpickle-0.4.0.ebuild,v 1.3 2011/09/09 10:53:14 jlec Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="*-jython"

inherit distutils

DESCRIPTION="Python library for serializing any arbitrary object graph into JSON"
HOMEPAGE="http://jsonpickle.github.com/ http://pypi.python.org/pypi/jsonpickle"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="dev-python/simplejson"
DEPEND="${RDEPEND}
	test? ( dev-python/feedparser )"

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" tests/runtests.py
	}
	python_execute_function testing
}
