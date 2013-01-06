# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/cbind/cbind-6.0.1.ebuild,v 1.2 2012/12/13 11:12:49 george Exp $

# !NOTE!
# this is a utility, no libs generated, no reason to do the gnat.eclass dance
# so, "inherit gnat" should not appear here!

DESCRIPTION="This tool is designed to aid in the creation of Ada bindings to C."
SRC_URI="http://dev.gentoo.org/~george/src/${P}.tar.bz2"
HOMEPAGE="http://www.rational.com/"
LICENSE="GMGPL"

DEPEND="virtual/ada"
RDEPEND="${DEPEND}"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

src_compile() {
	MAKEOPTS="${MAKEOPTS} -j1" emake || die
}

src_install () {
	make PREFIX="${D}"/usr/ install || die
	dodoc README DOCS
}
