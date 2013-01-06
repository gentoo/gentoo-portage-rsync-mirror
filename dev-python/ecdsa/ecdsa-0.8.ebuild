# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ecdsa/ecdsa-0.8.ebuild,v 1.2 2012/09/18 04:28:48 mr_bones_ Exp $

EAPI="4"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils vcs-snapshot

DESCRIPTION="ECDSA cryptographic signature library in pure Python"
HOMEPAGE="http://github.com/warner/python-ecdsa"
SRC_URI="https://github.com/warner/python-${PN}/tarball/python-${P} -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="test? ( dev-libs/openssl:0 )"

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" ${PN}/test_pyecdsa.py
	}
	python_execute_function testing
}
