# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/reverend/reverend-0.4.ebuild,v 1.3 2010/12/26 15:41:28 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="Reverend"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Reverend - Simple Bayesian classifier"
HOMEPAGE="http://divmod.org/trac/wiki/DivmodReverend http://pypi.python.org/pypi/Reverend"
SRC_URI="mirror://sourceforge/reverend/${MY_P}.tar.gz mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

DOCS="README.txt changelog.txt"

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
	fi
}
