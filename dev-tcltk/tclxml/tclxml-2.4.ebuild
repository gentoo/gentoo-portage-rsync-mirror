# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclxml/tclxml-2.4.ebuild,v 1.19 2010/12/07 12:06:39 jlec Exp $

DESCRIPTION="Pure Tcl implementation of an XML parser."
HOMEPAGE="http://tclxml.sourceforge.net/"
SRC_URI="mirror://sourceforge/tclxml/${P}.tar.gz"
IUSE=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 alpha sparc ~amd64"

DEPEND=">=dev-lang/tcl-8.3.3"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "s/relid'/relid/" \
		configure tcl.m4 tclconfig/tcl.m4 expat/configure || die
}

src_compile() {
	econf
	make || die

	# Need to hack the config script.
	sed -i 's:NONE:/usr:' TclxmlConfig.sh || die
}

src_install() {
	einstall || die
	dodoc ChangeLog README RELNOTES || die
}
