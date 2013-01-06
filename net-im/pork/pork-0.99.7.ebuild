# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/pork/pork-0.99.7.ebuild,v 1.4 2007/07/12 05:34:47 mr_bones_ Exp $

DESCRIPTION="Console based AIM client that looks like ircII"
HOMEPAGE="http://dev.ojnk.net/"
SRC_URI="mirror://sourceforge/ojnk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~alpha ~sparc ~ppc ~amd64"
IUSE="perl"

DEPEND="perl? ( dev-lang/perl )
	sys-libs/ncurses"

src_compile() {
	local myconf=""
	use perl || myconf="${myconf} --disable-perl"
	einfo "Configure options: ${myconf}"
	econf ${myconf} || die "econf failed"
	emake
}

src_install() {
	einstall

	doman doc/pork.1
	insinto /usr/share/pork/examples
	doins examples/blist.txt

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README STYLE TODO QUICK_START
}

pkg_postinst() {
	elog "Be aware that the syntax for IRC connections has"
	elog "changed. Read ${HOMEPAGE}/stuff/pork.news"
	elog "for details."
}
