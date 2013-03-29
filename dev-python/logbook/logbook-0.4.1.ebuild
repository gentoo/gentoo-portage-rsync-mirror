# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/logbook/logbook-0.4.1.ebuild,v 1.3 2013/03/29 21:01:39 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7,3_1,3_2} )

inherit distutils-r1 eutils

MY_PN=${PN/l/L}
MY_P=${MY_PN}-${PV}

DESCRIPTION="A logging replacement for Python"
HOMEPAGE="http://packages.python.org/Logbook/ http://pypi.python.org/pypi/Logbook"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="test? ( virtual/python-json[${PYTHON_USEDEP}] )"

DOCS=( CHANGES README )

S=${WORKDIR}/${MY_P}

python_prepare_all() {
	local PATCHES=(
		"${FILESDIR}"/${P}-testspy3.patch
	)

	distutils-r1_python_prepare_all
}

python_test() {
	esetup.py test
}
