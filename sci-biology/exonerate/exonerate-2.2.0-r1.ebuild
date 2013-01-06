# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/exonerate/exonerate-2.2.0-r1.ebuild,v 1.4 2011/12/13 14:56:55 jlec Exp $

EAPI=4

inherit autotools eutils toolchain-funcs

DESCRIPTION="Generic tool for pairwise sequence comparison"
HOMEPAGE="http://www.ebi.ac.uk/~guy/exonerate/"
SRC_URI="http://www.ebi.ac.uk/~guy/exonerate/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc-macos ~x64-macos"
IUSE="utils threads"

DEPEND="dev-libs/glib:2"
RDEPEND="${DEPEND}"

src_prepare() {
	tc-export CC
	sed \
		-e 's: -O3 -finline-functions::g' \
		-i configure.in || die
	epatch "${FILESDIR}"/${P}-asneeded.patch
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable utils utilities) \
		$(use_enable threads pthreads) \
		--enable-largefile \
		--enable-glib2
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	doman doc/man/man1/*.1
	dodoc README TODO NEWS AUTHORS ChangeLog || die
}
