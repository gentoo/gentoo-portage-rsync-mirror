# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/vatnumber/vatnumber-1.1.ebuild,v 1.2 2014/03/31 20:31:21 mgorny Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="Module to validate VAT numbers"
HOMEPAGE="http://code.google.com/p/vatnumber/"
SRC_URI="http://vatnumber.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test vies"

RDEPEND="vies? ( dev-python/suds )"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/suds )"

PARCHES=( "${FILESDIR}"/${P}-skiptest.patch )

python_test() {
	esetup.py test
}

src_install() {
	distutils-r1_src_install
	dodoc COPYRIGHT README CHANGELOG
}
