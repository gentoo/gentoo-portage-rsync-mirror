# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyro/pyro-3.16.ebuild,v 1.4 2012/05/29 20:03:06 ranger Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit distutils

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

PYTHON_MODNAME="Pyro"

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r docs/* || die "Installation of documentation failed"
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die "Installation of examples failed"
	fi
}
