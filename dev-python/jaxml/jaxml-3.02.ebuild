# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/jaxml/jaxml-3.02.ebuild,v 1.7 2010/10/25 02:51:22 jer Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="XML generator written in Python"
HOMEPAGE="http://www.librelogiciel.com/software/jaxml/action_Presentation http://pypi.python.org/pypi/jaxml"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ia64 ppc x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

PYTHON_MODNAME="jaxml.py"

src_install() {
	distutils_src_install

	insinto /usr/share/doc/${PF}/test
	doins test/* || die "doins failed"
}
