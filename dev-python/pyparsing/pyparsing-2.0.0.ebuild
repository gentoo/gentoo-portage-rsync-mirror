# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyparsing/pyparsing-2.0.0.ebuild,v 1.2 2013/09/05 18:46:37 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{3_2,3_3} )

inherit distutils-r1

DESCRIPTION="pyparsing is an easy-to-use Python module for text parsing"
HOMEPAGE="http://pyparsing.wikispaces.com/ http://pypi.python.org/pypi/pyparsing"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="py3"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="doc examples"

RDEPEND="!dev-python/pyparsing:0"

python_install_all() {
	local HTML_DOCS=( HowToUsePyparsing.html )
	use doc && HTML_DOCS+=( htmldoc/ )

	distutils-r1_python_install_all

	use doc && dodoc docs/*.pdf
	use examples && dodoc -r examples
}
