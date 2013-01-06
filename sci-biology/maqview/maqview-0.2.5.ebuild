# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/maqview/maqview-0.2.5.ebuild,v 1.3 2010/09/16 17:22:19 scarabeus Exp $

inherit autotools

DESCRIPTION="GUI for sci-biology/maq, a short read mapping assembler"
HOMEPAGE="http://maq.sourceforge.net/"
SRC_URI="mirror://sourceforge/maq/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS="amd64 x86"

DEPEND="media-libs/freeglut"
RDEPEND="${DEPEND}
	sci-biology/maq"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
