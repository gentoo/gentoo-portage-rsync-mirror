# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/fbgetty/fbgetty-0.1.698-r1.ebuild,v 1.1 2014/12/04 07:44:46 pinkbyte Exp $

EAPI=5

inherit eutils

DESCRIPTION="An extended getty for the framebuffer console"
HOMEPAGE="http://projects.meuh.org/fbgetty/"
SRC_URI="http://projects.meuh.org/${PN}/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

src_prepare() {
	epatch "${FILESDIR}/${P}-gcc41.patch"

	epatch_user
}

src_install() {
	default

	docompress -x "/usr/share/doc/${PF}/examples"
	insinto "/usr/share/doc/${PF}/examples"
	doins examples/{issue.*,inittab.*}
}
