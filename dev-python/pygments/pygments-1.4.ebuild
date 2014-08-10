# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygments/pygments-1.4.ebuild,v 1.9 2014/08/10 21:16:43 slyfox Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

MY_PN="Pygments"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Pygments is a syntax highlighting package written in Python"
HOMEPAGE="http://pygments.org/ http://pypi.python.org/pypi/Pygments"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="doc test"

DEPEND="test? (
		dev-python/nose
		virtual/ttf-fonts
	)"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-fix_tests.patch"
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" tests/run.py
	}
	python_execute_function testing
}

src_install(){
	distutils_src_install

	if use doc; then
		dohtml -r docs/build || die "Installation of documentation failed"
	fi
}
