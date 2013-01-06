# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/yenc/yenc-0.4.0.ebuild,v 1.1 2013/01/03 20:33:33 jsbronder Exp $

EAPI="4"
PYTHON_DEPEND="2:2.6"

inherit eutils distutils

DESCRIPTION="Module providing raw yEnc encoding/decoding"
HOMEPAGE="http://www.golug.it/yenc.html"
SRC_URI="http://www.golug.it/pub/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare(){
	# Remove forced CFLAG on setup.py
	epatch "${FILESDIR}/${PN}-remove-cflags.patch"
}

python_test() {
	PYTHONPATH="${BUILD_DIR}/lib" \
		"${PYTHON}" test/test.py || die "Test failed."
}

src_install() {
	distutils_src_install
	dodoc doc/${PN}-draft.1.3.txt
}
