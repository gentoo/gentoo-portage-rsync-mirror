# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libstatgrab/libstatgrab-0.16.ebuild,v 1.5 2013/01/20 19:32:12 ago Exp $

DESCRIPTION="a tool to provide access to statistics about the system on which it's run."
HOMEPAGE="http://www.i-scream.org/libstatgrab/"
SRC_URI="http://www.mirrorservice.org/sites/ftp.i-scream.org/pub/i-scream/libstatgrab/${P}.tar.gz"

LICENSE="|| ( GPL-2 LGPL-2.1 )"
SLOT=0
KEYWORDS="amd64 ~ia64 ppc x86"
IUSE=""

src_compile() {
	econf --disable-setgid-binaries --disable-setuid-binaries \
		--disable-deprecated --with-ncurses
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog PLATFORMS NEWS AUTHORS README
}
