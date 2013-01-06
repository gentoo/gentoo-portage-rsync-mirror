# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bitstring/bitstring-3.0.1.ebuild,v 1.2 2012/02/21 03:38:15 patrick Exp $

EAPI=3
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="2.5"
inherit distutils

DESCRIPTION="A pure Python module for creation and analysis of binary data"
HOMEPAGE="http://python-bitstring.googlecode.com/"
SRC_URI="http://python-bitstring.googlecode.com/files/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="app-arch/unzip"

src_test() {
	testing() {
		PYTHONPATH="../build-${PYTHON_ABI}/lib" "$(PYTHON)" test_${PN}.py
	}
	pushd test > /dev/null
	python_execute_function testing
	popd > /dev/null
}
