# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/easychem/easychem-0.6.ebuild,v 1.15 2012/05/04 07:02:33 jdhore Exp $

EAPI="1"

inherit eutils

DESCRIPTION="Chemical structure drawing program - focused on presentation"
HOMEPAGE="http://easychem.sourceforge.net/"
SRC_URI="mirror://sourceforge/easychem/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="
	x11-libs/gtk+:2
	app-text/ghostscript-gpl
	media-gfx/pstoedit"
DEPEND="${RDEPEND}
		virtual/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-prestrip.patch"
}

src_compile() {
	ln -s Makefile.linux Makefile
	DGS_PATH=/usr/bin DPSTOEDIT_PATH=/usr/bin \
		C_FLAGS="${CFLAGS}" emake -e || die
}

src_install () {
	dobin easychem || die
	dodoc TODO || die
}
