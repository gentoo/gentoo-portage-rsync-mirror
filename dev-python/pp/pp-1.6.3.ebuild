# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pp/pp-1.6.3.ebuild,v 1.1 2013/01/11 07:32:32 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Parallel and distributed programming for Python"
HOMEPAGE="http://www.parallelpython.com/"
SRC_URI="http://www.parallelpython.com/downloads/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="pp.py ppauto.py pptransport.py ppworker.py"

src_install() {
	distutils_src_install

	doman doc/ppserver.1
	use doc && dohtml doc/ppdoc.html

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r "${S}/examples"
	fi
}
