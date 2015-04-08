# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyparsing/pyparsing-2.0.1.ebuild,v 1.13 2014/04/03 17:49:41 radhermit Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="pyparsing is an easy-to-use Python module for text parsing"
HOMEPAGE="http://pyparsing.wikispaces.com/ http://pypi.python.org/pypi/pyparsing"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="doc examples"

RDEPEND="!dev-python/pyparsing:py2 !dev-python/pyparsing:py3"

python_install_all() {
	local HTML_DOCS=( HowToUsePyparsing.html )
	use doc && HTML_DOCS+=( htmldoc/ )

	distutils-r1_python_install_all

	use doc && dodoc docs/*.pdf
	use examples && dodoc -r examples
}
