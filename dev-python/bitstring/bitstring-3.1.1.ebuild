# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bitstring/bitstring-3.1.1.ebuild,v 1.2 2013/03/24 02:24:48 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2} )
inherit distutils-r1

DESCRIPTION="A pure Python module for creation and analysis of binary data"
HOMEPAGE="http://python-bitstring.googlecode.com/"
SRC_URI="http://python-bitstring.googlecode.com/files/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="app-arch/unzip"

python_test() {
	pushd test > /dev/null
	PYTHONPATH="${BUILD_DIR}"/lib "${PYTHON}" -m unittest test_bitarray       || die "test_bitarray failed"
	PYTHONPATH="${BUILD_DIR}"/lib "${PYTHON}" -m unittest test_bits           || die "test_bits failed"
	PYTHONPATH="${BUILD_DIR}"/lib "${PYTHON}" -m unittest test_bitstore       || die "test_bitstore failed"
	PYTHONPATH="${BUILD_DIR}"/lib "${PYTHON}" -m unittest test_bitstream      || die "test_bitstream failed"
	PYTHONPATH="${BUILD_DIR}"/lib "${PYTHON}" -m unittest test_bitstring      || die "test_bitstring failed"
	PYTHONPATH="${BUILD_DIR}"/lib "${PYTHON}" -m unittest test_constbitstream || die "test_constbitstream failed"
	popd > /dev/null
}
