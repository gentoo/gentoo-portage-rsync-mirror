# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/cddb/cddb-0.2.ebuild,v 1.4 2011/04/20 15:28:29 voyageur Exp $

inherit gnustep-2

S=${WORKDIR}/${PN}.bundle

DESCRIPTION="GNUstep bundle for cddb acces"
HOMEPAGE="http://gsburn.sf.net"
SRC_URI="mirror://sourceforge/gsburn/${PN}.bundle-${PV}.tar.gz"

KEYWORDS="amd64 x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-gnustep-make-2.patch
	epatch "${FILESDIR}"/${P}-bool.patch
}
