# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pydispatcher/pydispatcher-2.0.2.ebuild,v 1.2 2010/12/26 15:14:36 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="PyDispatcher"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Multi-producer-multi-consumer signal dispatching mechanism"
HOMEPAGE="http://pydispatcher.sourceforge.net/ http://pypi.python.org/pypi/PyDispatcher"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE="doc examples"

DEPEND="dev-python/setuptools"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="pydispatch"

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		PYTHONPATH="." "$(PYTHON -f)" docs/pydoc/builddocs.py || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		insinto /usr/share/doc/${PF}/html
		doins -r docs/*

		dohtml -r *.html
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
	fi
}
