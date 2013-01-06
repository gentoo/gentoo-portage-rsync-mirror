# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgasync/pgasync-2.01.ebuild,v 1.3 2011/01/08 16:30:29 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="An asynchronous api to postgres for twisted."
HOMEPAGE="http://www.jamwt.com/pgasync/"
SRC_URI="http://www.jamwt.com/pgasync/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND=">=dev-python/twisted-1.3"
RDEPEND="${DEPEND}"

DOCS="CHANGELOG PKG-INFO README TODO"

src_install() {
	distutils_src_install

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die "doins failed"
	fi
}
