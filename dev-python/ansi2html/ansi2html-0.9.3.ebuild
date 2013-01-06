# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ansi2html/ansi2html-0.9.3.ebuild,v 1.1 2012/10/25 10:51:54 iksaif Exp $

EAPI="4"

# ordereddict is need for < 2.7, but it's not packaged (yet)
PYTHON_DEPEND="*:2.7"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"
RESTRICT_PYTHON_ABIS="2.5 2.5-jython"

inherit distutils

DESCRIPTION="Convert text with ANSI color codes to HTML"
HOMEPAGE="http://pypi.python.org/pypi/ansi2html https://github.com/ralphbean/ansi2html"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/six"
DEPEND="${RDEPEND}
	test? (
		dev-python/nose
		dev-python/mock
	)
	dev-python/setuptools"

src_prepare() {
	if use test; then
		epatch "${FILESDIR}/${PN}-0.9.1-fix-sys-argv-in-tests.patch"
	fi
}
