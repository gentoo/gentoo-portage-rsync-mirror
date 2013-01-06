# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/sendxmpp/sendxmpp-0.0.6.ebuild,v 1.4 2007/07/02 14:46:17 peper Exp $

inherit eutils
DESCRIPTION="sendxmpp is a perl-script to send xmpp (jabber), similar to what mail(1) does for mail."
HOMEPAGE="http://www.djcbsoftware.nl/code/sendxmpp/"
SRC_URI="http://www.djcbsoftware.nl/code/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc ~sparc x86"
IUSE=""
#RESTRICT="strip"
DEPEND="dev-perl/Net-XMPP"
#RDEPEND=""

#S=${WORKDIR}/${P}

src_compile() {
	perl Makefile.PL \
		PREFIX=/usr DESTDIR=${D}

	make || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc Changes README INSTALL
}
