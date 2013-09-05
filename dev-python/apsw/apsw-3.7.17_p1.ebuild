# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/apsw/apsw-3.7.17_p1.ebuild,v 1.3 2013/09/05 18:46:50 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

MY_P=${PN}-${PV/_p/-r}

DESCRIPTION="APSW - Another Python SQLite Wrapper"
HOMEPAGE="http://code.google.com/p/apsw/"
SRC_URI="http://apsw.googlecode.com/files/${MY_P}.zip"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="doc"

RDEPEND=">=dev-db/sqlite-${PV%_p*}"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${MY_P}

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
