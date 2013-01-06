# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/socketpool/socketpool-0.5.2.ebuild,v 1.1 2012/11/16 02:39:07 idella4 Exp $

EAPI=4
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="2.5 3.*"
inherit distutils

DESCRIPTION="A simple Python socket pool"
HOMEPAGE="http://github.com/benoitc/socketpool/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64"
IUSE="examples"
LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/gevent"
DEPEND="${RDEPEND}
	dev-python/setuptools"

src_install() {
	distutils_src_install
	if use examples; then
		docompress -x usr/share/doc/${P}/examples
		insinto usr/share/doc/${P}
		doins -r examples/
	fi
}
