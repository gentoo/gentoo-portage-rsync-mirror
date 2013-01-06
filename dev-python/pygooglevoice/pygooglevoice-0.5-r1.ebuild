# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygooglevoice/pygooglevoice-0.5-r1.ebuild,v 1.2 2012/02/23 15:10:20 radhermit Exp $

EAPI="4"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_MODNAME="googlevoice"

inherit distutils eutils

DESCRIPTION="Python Bindings for the Google Voice API"
HOMEPAGE="http://code.google.com/p/pygooglevoice/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz
	http://${PN}.googlecode.com/files/${P}-extras.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND="app-arch/unzip"

# Requires interactive login
RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}"/${P}-auth.patch
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" googlevoice/tests.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc ; then
		dohtml -r "${WORKDIR}"/doc/*
	fi

	if use examples ; then
		exeinto /usr/share/doc/${PF}/examples
		doexe "${WORKDIR}"/examples/[a-z]*.py
	fi
}
