# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/myghty/myghty-1.2.ebuild,v 1.3 2014/08/10 21:14:10 slyfox Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_PN="Myghty"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Template and view-controller framework derived from HTML::Mason"
HOMEPAGE="http://www.myghty.org/ http://pypi.python.org/pypi/Myghty"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=dev-python/routes-1.0
	dev-python/paste
	dev-python/pastedeploy
	dev-python/pastescript"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		cd doc
		PYTHONPATH="lib" "$(PYTHON -f)" genhtml.py || die "Generation of documentation failed"
	fi
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test/alltests.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml doc/html/* || die "Installation of documentation failed"
	fi
}
