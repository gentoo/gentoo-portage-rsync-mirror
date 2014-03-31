# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyro/pyro-3.16-r1.ebuild,v 1.5 2014/03/31 21:25:53 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} pypy pypy2_0 )

inherit distutils-r1

MY_PN="Pyro"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Advanced and powerful Distributed Object Technology system written entirely in Python"
HOMEPAGE="http://www.xs4all.nl/~irmen/pyro3/ http://pypi.python.org/pypi/Pyro"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="3"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE="doc examples"

DEPEND="!dev-python/pyro:0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

python_install_all() {
	use doc && HTML_DOCS=( docs/. )
	distutils-r1_python_install_all

	if use examples; then
		insinto /usr/share/${P}
		doins -r examples
	fi
}
