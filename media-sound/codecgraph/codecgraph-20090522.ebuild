# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/codecgraph/codecgraph-20090522.ebuild,v 1.2 2014/08/10 21:04:44 slyfox Exp $

inherit eutils

DESCRIPTION="Generates a graph based on the ALSA description of an HD Audio codec"
HOMEPAGE="http://helllabs.org/codecgraph/"
SRC_URI="http://helllabs.org/codecgraph/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-lang/python
	 media-gfx/graphviz"

DEPEND="${RDEPEND}
	media-gfx/imagemagick"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-makefile-prefix.diff"
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc codecs.txt README BUGS IDEAS
}
