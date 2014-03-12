# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/lz4/lz4-0.6.0_p20140104.ebuild,v 1.2 2014/03/12 07:25:22 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="LZ4 Bindings for Python"
HOMEPAGE="https://pypi.python.org/pypi/lz4 https://github.com/steeve/python-lz4"
#SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
SRC_URI="http://dev.gentoo.org/~jlec/distfiles/${P}.tar.xz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND=""
DEPEND="
	test? (	dev-python/nose )"

python_prepare_all() {
	sed \
		-e '/nose/d' \
		-i setup.py || die
}

python_test() {
	cd tests || die
	nosetests || die
}
