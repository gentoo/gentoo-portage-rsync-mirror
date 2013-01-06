# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/celementtree/celementtree-1.0.5-r1.ebuild,v 1.13 2012/02/22 08:57:01 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-* *-jython"

inherit distutils eutils

MY_P="cElementTree-${PV}-20051216"

DESCRIPTION="The cElementTree module is a C implementation of the ElementTree API"
HOMEPAGE="http://effbot.org/zone/celementtree.htm http://pypi.python.org/pypi/cElementTree"
SRC_URI="http://effbot.org/downloads/${MY_P}.tar.gz"

LICENSE="ElementTree"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos ~sparc-solaris"
IUSE="doc"

RDEPEND=">=dev-python/elementtree-1.2
	>=dev-libs/expat-1.95.8"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-use_system_expat.patch"
	epatch "${FILESDIR}/${P}-setuptools.patch"
}

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" selftest.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		insinto /usr/share/doc/${PF}/samples
		doins samples/* selftest.py || die "doins failed"
	fi
}
