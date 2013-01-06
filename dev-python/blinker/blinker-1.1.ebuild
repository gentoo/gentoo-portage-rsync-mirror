# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/blinker/blinker-1.1.ebuild,v 1.1 2011/02/12 17:31:24 arfrever Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Fast, simple object-to-object and broadcast signaling"
HOMEPAGE="http://discorporate.us/projects/Blinker/ http://pypi.python.org/pypi/blinker"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="app-arch/unzip"
RDEPEND=""

src_install() {
	distutils_src_install

	if use doc; then
		pushd docs/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static || die "Installation of documentation failed"
		popd > /dev/null
	fi
}
