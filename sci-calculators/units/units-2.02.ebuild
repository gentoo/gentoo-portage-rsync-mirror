# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/units/units-2.02.ebuild,v 1.3 2013/08/10 12:56:35 ago Exp $

EAPI=5
inherit autotools eutils

DESCRIPTION="Unit conversion program"
HOMEPAGE="http://www.gnu.org/software/units/units.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="FDL-1.3 GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm hppa ppc ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="
	>=sys-libs/readline-4.1-r2
"
RDEPEND="
	|| (
		dev-lang/python:2.5[xml]
		dev-lang/python:2.6[xml]
		dev-lang/python:2.7[xml]
	)
	${DEPEND}
"

DOCS=( ChangeLog NEWS README )

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.01-install.patch
	eautoreconf
}
