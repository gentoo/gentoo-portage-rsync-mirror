# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/units/units-2.00.ebuild,v 1.9 2012/12/07 17:50:48 jer Exp $

EAPI=4
inherit eutils

DESCRIPTION="Unit conversion program"
HOMEPAGE="http://www.gnu.org/software/units/units.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ppc sparc x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="
	>=sys-libs/readline-4.1-r2
"
RDEPEND="
	|| ( dev-lang/python:2.5 dev-lang/python:2.6 dev-lang/python:2.7 )
	${DEPEND}
"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch

	# Fix shebang for python2
	sed -i units_cur -e '1s|$|2|' || die
}

src_install() {
	emake -j1 DESTDIR="${D}" install
	dodoc ChangeLog NEWS README
}
