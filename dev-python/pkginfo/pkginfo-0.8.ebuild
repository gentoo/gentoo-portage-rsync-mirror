# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pkginfo/pkginfo-0.8.ebuild,v 1.1 2012/04/27 12:49:29 tampakrap Exp $

EAPI=4
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.*"
inherit distutils eutils

DESCRIPTION="Provides an API for querying the distutils metadata written in a PKG-INFO file"
HOMEPAGE="http://pypi.python.org/pypi/pkginfo"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

LICENSE="MIT"
SLOT="0"
DEPEND="doc? ( dev-python/sphinx )
	dev-python/setuptools"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -e  's:SPHINXBUILD   = sphinx-build:SPHINXBUILD   = /usr/bin/sphinx-build:' \
		-i docs/Makefile || die
}

src_compile() {
	distutils_src_compile
	if use doc; then
		emake -C docs html
	fi
}

src_test() {
	testing() {
		pushd pkginfo/tests/ > /dev/null
		for test in test_*.py; do
			PYTHONPATH="../../build-${PYTHON_ABI}/lib/" \
			"$(PYTHON)" "${test}" || die "${test} failed with Python ${PYTHON_ABI}"
			if [[ $? ]]; then
				einfo "Test "${test}" successful"
			fi
		done
		popd > /dev/null
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r docs/.build/html/*
	fi

	if use examples; then
		insinto usr/share/doc/${PF}/
		doins -r docs/examples/
	fi
}
