# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsetleds/xsetleds-0.1.3.ebuild,v 1.16 2008/01/07 10:42:10 nelchael Exp $

DESCRIPTION="small tool to report and change the keyboard LED states of an X display"
HOMEPAGE="ftp://ftp.unix-ag.org/user/bmeurer/xsetleds/"
SRC_URI="ftp://ftp.unix-ag.org/user/bmeurer/xsetleds/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa ~mips amd64 ia64"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXtst"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	x11-proto/xextproto
	x11-proto/xproto"

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog README TODO
}
