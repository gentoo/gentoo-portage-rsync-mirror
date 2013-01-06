# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/units/units-2.01.ebuild,v 1.11 2012/12/30 20:41:59 ago Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="Unit conversion program"
HOMEPAGE="http://www.gnu.org/software/units/units.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ppc sparc x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="
	>=sys-libs/readline-4.1-r2
"
RDEPEND="
	|| ( dev-lang/python:2.5 dev-lang/python:2.6 dev-lang/python:2.7 )
	${DEPEND}
"

DOCS=( ChangeLog NEWS README )

src_prepare() {
	# Fix parallel make install
	epatch "${FILESDIR}"/${P}-install.patch
	eautoreconf

	# Fix shebang for python2
	sed -i units_cur -e '1s|$|2|' || die
}
