# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xlhtml/xlhtml-0.5.ebuild,v 1.16 2015/01/31 01:41:00 patrick Exp $

inherit autotools

DESCRIPTION="Convert MS Excel and Powerpoint files to HTML"
HOMEPAGE="http://chicago.sourceforge.net/xlhtml/"
SRC_URI="mirror://sourceforge/chicago/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ppc ~sparc x86"
IUSE=""
DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	# This is needed specifically for depcomp, which is necessary for
	# building xlhtml, but isn't included.
	eautoreconf
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed for ${P}"
	dodoc AUTHORS COPYING INSTALL README
	docinto cole
	dodoc cole/{AUTHORS,COPYING,NEWS,ChangeLog,THANKS,TODO}
	docinto ppthtml
	dodoc ppthtml/{ChangeLog,README,THANKS}
	docinto xlhtml
	dodoc xlhtml/{ChangeLog,README,THANKS,TODO}
	rm -rf xlhtml/contrib/CVS
	cp -pPR xlhtml/contrib "${D}"/usr/share/doc/${PF}/xlhtml
}
