# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/urlview/urlview-0.9.ebuild,v 1.27 2008/02/03 15:43:44 grobian Exp $

inherit eutils

DESCRIPTION="extracts urls from text and will send them to another app"
HOMEPAGE="http://www.mutt.org"
SRC_URI="ftp://gd.tuwien.ac.at/infosys/mail/mutt/contrib/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/no-trailing-newline.patch
	epatch "${FILESDIR}"/include-fix.patch
	epatch "${FILESDIR}"/${P}-DESTDIR.patch
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc README INSTALL ChangeLog AUTHORS sample.urlview
	dobin url_handler.sh
}

pkg_postinst() {
	echo
	einfo "There is a sample.urlview in /usr/share/doc/${P}"
	einfo "You can also customize /usr/bin/url_handler.sh"
	echo
	einfo "If using urlview from mutt, you may need to "set pipe_decode" in"
	einfo "your ~/.muttrc to prevent garbled URLs."
	echo
}
