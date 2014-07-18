# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/cirkuit/cirkuit-0.4.3-r1.ebuild,v 1.3 2014/07/18 14:34:06 nimiux Exp $

EAPI=5

KDE_MINIMAL="4.12.0"
inherit kde4-base

DESCRIPTION="An application to generate publication-ready figures"
HOMEPAGE="http://wwwu.uni-klu.ac.at/magostin/cirkuit.html"
SRC_URI="http://wwwu.uni-klu.ac.at/magostin/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE="debug"

DEPEND="
	>=app-text/poppler-0.12.3-r3[qt4]
"
RDEPEND="${DEPEND}
	virtual/latex-base
	media-libs/netpbm
	dev-texlive/texlive-pstricks
	app-text/ghostscript-gpl
	app-text/ps2eps
	media-gfx/pdf2svg
"

DOCS=( Changelog README )

src_install() {
	kde4-base_src_install

	# bug 496694 - this file is part of >=kde-base/katepart-4.12.0
	rm "${D}"/usr/share/apps/katepart/syntax/gnuplot.xml || die
}
