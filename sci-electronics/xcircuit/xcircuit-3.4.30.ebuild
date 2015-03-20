# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/xcircuit/xcircuit-3.4.30.ebuild,v 1.7 2015/03/20 15:25:12 jlec Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="Circuit drawing and schematic capture program"
SRC_URI="http://opencircuitdesign.com/xcircuit/archive/${P}.tgz"
HOMEPAGE="http://opencircuitdesign.com/xcircuit"

KEYWORDS="amd64 ppc x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

RDEPEND="app-text/ghostscript-gpl
	dev-lang/tk:0
	x11-libs/libXt"
DEPEND="${RDEPEND}"

RESTRICT="test" #131024

src_prepare() {
	sed -i -e 's:$(datadir):$(libdir):g' Makefile.am || die "sed failed"
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--with-tcl \
		--with-ngspice
}

src_install () {
	emake DESTDIR="${D}" appdefaultsdir="/usr/share/X11/app-defaults" \
		appmandir="/usr/share/man/man1" install || die "emake install failed"
	dodoc CHANGES README* TODO
}
