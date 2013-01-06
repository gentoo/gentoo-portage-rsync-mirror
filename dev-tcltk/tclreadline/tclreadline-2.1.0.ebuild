# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclreadline/tclreadline-2.1.0.ebuild,v 1.18 2012/11/04 19:52:08 jlec Exp $

DESCRIPTION="Readline extension to TCL"
HOMEPAGE="http://tclreadline.sf.net/"
SRC_URI="mirror://sourceforge/tclreadline/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="alpha ~amd64 ppc ~sparc x86"
IUSE=""

DEPEND="
	dev-lang/tcl
	sys-libs/readline"
RDEPEND="${DEPEND}"

src_compile() {
	econf
	emake CFLAGS="${CFLAGS}" || die
}

src_install () {
	emake DESTDIR="${D}" install || die
}
