# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/units/units-2.01-r3.ebuild,v 1.1 2013/07/08 10:27:56 jer Exp $

EAPI=5
inherit autotools eutils

DESCRIPTION="Unit conversion program"
HOMEPAGE="http://www.gnu.org/software/units/units.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux"
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
	epatch "${FILESDIR}"/${P}-install.patch
	cp "${FILESDIR}"/${P}_cur ${PN}_cur
	eautoreconf
}
