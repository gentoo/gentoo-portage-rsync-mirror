# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/iTeML/iTeML-2.0.1.ebuild,v 1.1 2013/07/22 00:52:55 aballier Exp $

EAPI=5

inherit oasis

DESCRIPTION="Inline (Unit) Tests for OCaml"
HOMEPAGE="https://github.com/vincent-hugot/iTeML"
SRC_URI="https://github.com/vincent-hugot/iTeML/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-ml/oasis"
RDEPEND="${DEPEND}"

DOCS=( "${WORKDIR}/${P}/README.md" )

S="${WORKDIR}/${P}/qtest"

src_prepare() {
	oasis setup || die
}
