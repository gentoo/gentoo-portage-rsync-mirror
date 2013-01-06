# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-bibtex/python-bibtex-1.2.4.ebuild,v 1.11 2012/05/04 15:12:16 patrick Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils eutils

DESCRIPTION="A Python extension to parse BibTeX files"
HOMEPAGE="http://pybliographer.org/"
SRC_URI="mirror://sourceforge/pybliographer/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	>=app-text/recode-3.6-r1"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	distutils_src_prepare

	epatch "${FILESDIR}/${P}-fix_tests.patch"

	# Disable tests during installation.
	sed -e "/self.run_command ('check')/d" -i setup.py
}

src_test() {
	testing() {
		"$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" check
	}
	python_execute_function testing
}
