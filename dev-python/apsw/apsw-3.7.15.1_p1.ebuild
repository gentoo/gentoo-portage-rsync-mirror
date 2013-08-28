# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/apsw/apsw-3.7.15.1_p1.ebuild,v 1.2 2013/08/28 16:01:09 floppym Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_5,2_6,2_7,3_1,3_2,3_3} )

inherit distutils-r1

MY_PV="${PV/_p/-r}"

DESCRIPTION="APSW - Another Python SQLite Wrapper"
HOMEPAGE="http://code.google.com/p/apsw/"
SRC_URI="http://apsw.googlecode.com/files/${PN}-${MY_PV}.zip"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="doc"

RDEPEND=">=dev-db/sqlite-${PV%_p*}"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/${PN}-${MY_PV}"

PATCHES=( "${FILESDIR}"/${PN}-3.6.20.1-fix_tests.patch )

python_compile() {
	if [[ ${EPYTHON} == python2* ]]; then
		local CFLAGS="${CFLAGS} -fno-strict-aliasing"
		export CFLAGS
	fi
	distutils-r1_python_compile --enable=load_extension
}

src_test() {
	# tests use overlapping database files
	local DISTUTILS_NO_PARALLEL_BUILD=1
	distutils-r1_src_test
}

python_test() {
	"${PYTHON}" setup.py build_test_extension || die "Building of test loadable extension failed"
	"${PYTHON}" tests.py -v || die
}

python_install_all() {
	distutils-r1_python_install_all
	if use doc ; then
		dohtml -r doc/*
	fi
}
