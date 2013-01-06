# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xtermcontrol/xtermcontrol-2.10.ebuild,v 1.6 2010/10/12 16:54:07 armin76 Exp $

DESCRIPTION="xtermcontrol enables dynamic control of XFree86 xterm properties"
HOMEPAGE="http://www.thrysoee.dk/xtermcontrol/"
SRC_URI="http://www.thrysoee.dk/${PN}/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~sparc x86"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog
}
