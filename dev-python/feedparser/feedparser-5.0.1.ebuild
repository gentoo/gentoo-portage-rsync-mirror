# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/feedparser/feedparser-5.0.1.ebuild,v 1.9 2011/11/16 19:10:07 hwoarang Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
# 877 errors with Python 3.
PYTHON_TESTS_RESTRICTED_ABIS="3.* *-jython"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="*"

inherit distutils eutils

DESCRIPTION="Parse RSS and Atom feeds in Python"
HOMEPAGE="http://code.google.com/p/feedparser/ http://pypi.python.org/pypi/feedparser"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

# sgmllib is licensed under PSF-2.
LICENSE="BSD-2 PSF-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND=""

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"
DOCS="LICENSE NEWS"
PYTHON_MODNAME="feedparser.py _feedparser_sgmllib.py"

src_prepare() {
	mv feedparser/sgmllib3.py feedparser/_feedparser_sgmllib.py || die "Renaming sgmllib3.py failed"
	epatch "${FILESDIR}/${P}-sgmllib.patch"

	distutils_src_prepare

	preparation() {
		if [[ "${PYTHON_ABI}" == 3.* ]]; then
			2to3-${PYTHON_ABI} -nw --no-diffs feedparser/{feedparser.py,feedparsertest.py} || return 1
		else
			# Avoid SyntaxErrors with Python 2.
			echo "raise ImportError" > feedparser/_feedparser_sgmllib.py || return 1
		fi
	}
	python_execute_function -s preparation
}

src_compile() {
	PYTHONPATH="feedparser" distutils_src_compile
}

src_test() {
	testing() {
		cd feedparser || return 1
		PYTHONPATH="." "$(PYTHON)" feedparsertest.py
	}
	python_execute_function -s testing
}

src_install() {
	PYTHONPATH="feedparser" distutils_src_install
}
