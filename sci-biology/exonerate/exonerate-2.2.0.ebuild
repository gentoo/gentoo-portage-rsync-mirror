# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/exonerate/exonerate-2.2.0.ebuild,v 1.2 2011/03/10 19:08:18 jlec Exp $

EAPI="1"

DESCRIPTION="Generic tool for pairwise sequence comparison"
HOMEPAGE="http://www.ebi.ac.uk/~guy/exonerate/"
SRC_URI="http://www.ebi.ac.uk/~guy/exonerate/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="utils"

DEPEND="dev-libs/glib:2"
RDEPEND="${DEPEND}"

src_compile() {
	econf \
		$( use_enable utils utilities ) \
		--enable-largefile \
		--enable-glib2

	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	doman doc/man/man1/*.1
	dodoc README TODO NEWS AUTHORS ChangeLog || die
}
