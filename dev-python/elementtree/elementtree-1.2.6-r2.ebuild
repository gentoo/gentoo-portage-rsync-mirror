# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/elementtree/elementtree-1.2.6-r2.ebuild,v 1.15 2010/07/08 15:46:20 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_P="${P}-20050316"

DESCRIPTION="A light-weight XML object model for Python"
HOMEPAGE="http://effbot.org/zone/element-index.htm http://pypi.python.org/pypi/elementtree"
SRC_URI="http://effbot.org/downloads/${MY_P}.tar.gz"

LICENSE="ElementTree"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES"

src_prepare() {
	distutils_src_prepare
	sed -e "s/distutils.core/setuptools/" -i setup.py || die "sed failed"
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" selftest.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	dohtml docs/*
}
