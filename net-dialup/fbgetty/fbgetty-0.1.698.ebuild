# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/fbgetty/fbgetty-0.1.698.ebuild,v 1.11 2007/10/27 08:40:57 mrness Exp $

inherit eutils

DESCRIPTION="An extended getty for the framebuffer console"
HOMEPAGE="http://projects.meuh.org/fbgetty/"
SRC_URI="http://projects.meuh.org/fbgetty/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE=""

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-gcc41.patch"
}

src_install() {
	einstall || die "make install failed"
}
