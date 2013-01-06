# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyasn1-modules/pyasn1-modules-0.0.1a.ebuild,v 1.8 2011/05/29 16:27:50 armin76 Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="pyasn1 modules"
HOMEPAGE="http://pyasn1.sourceforge.net/ http://pypi.python.org/pypi/pyasn1-modules"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="dev-python/pyasn1"
DEPEND="${RDEPEND}
	dev-python/setuptools"

DOCS="CHANGES README"
PYTHON_MODNAME="pyasn1_modules"

src_install() {
	distutils_src_install

	insinto /usr/share/doc/${PF}/tools
	doins tools/* || die "doins failed"
}
