# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/weex/weex-2.6.1.5-r1.ebuild,v 1.2 2014/08/10 20:55:07 slyfox Exp $

inherit eutils

DESCRIPTION="Automates maintaining a web page or other FTP archive"
HOMEPAGE="http://weex.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="nls"

DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-va_list.patch"
	epatch "${FILESDIR}/formatstring.patch"
}

src_compile() {
	econf $(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc doc/TODO* doc/README* doc/FAQ* doc/sample* doc/ChangeLog* \
		doc/BUG* doc/THANK*
}
