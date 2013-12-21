# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/res/res-4.0.3.ebuild,v 1.2 2013/12/21 15:52:01 ago Exp $

EAPI=5

OASIS_BUILD_DOCS=1

inherit oasis

DESCRIPTION="Resizable Array and Buffer modules for O'Caml"
HOMEPAGE="http://bitbucket.org/mmottl/res"
SRC_URI="https://bitbucket.org/mmottl/res/downloads/${P}.tar.gz"
LICENSE="LGPL-2.1-with-linking-exception"

DEPEND=""
RDEPEND="${DEPEND}"
SLOT="0/${PV}"
KEYWORDS="~amd64 ppc ~x86"
IUSE="examples"

DOCS=( "AUTHORS.txt" "CHANGES.txt" "README.md" )

src_install() {
	oasis_src_install
	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
