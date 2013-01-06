# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/apsw/apsw-3.7.14.1_p1.ebuild,v 1.2 2012/12/08 21:39:55 floppym Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython 2.7-pypy-*"

inherit distutils eutils

MY_PV="${PV/_p/-r}"

DESCRIPTION="APSW - Another Python SQLite Wrapper"
HOMEPAGE="http://code.google.com/p/apsw/"
SRC_URI="http://apsw.googlecode.com/files/${PN}-${MY_PV}.zip"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="doc"

RDEPEND=">=dev-db/sqlite-${PV%_p*}[extensions]"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/${PN}-${MY_PV}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${PN}-3.6.20.1-fix_tests.patch"
}

src_compile() {
	distutils_src_compile --enable=load_extension
}

src_test() {
	echo "$(PYTHON -f)" setup.py build_test_extension
	"$(PYTHON -f)" setup.py build_test_extension || die "Building of test loadable extension failed"

	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" tests.py -v
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	if use doc ; then
		dohtml -r doc/*
	fi
}
