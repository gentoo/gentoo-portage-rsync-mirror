# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/vacation/vacation-1.2.6.3.ebuild,v 1.6 2008/08/10 20:00:29 gentoofan23 Exp $

inherit eutils toolchain-funcs

DESCRIPTION="automatic mail answering program"
HOMEPAGE="http://vacation.sourceforge.net/"
SRC_URI="mirror://sourceforge/vacation/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND="virtual/mta
	sys-libs/gdbm"
DEPEND="${RDEPEND}
	!mail-mta/sendmail"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "s:install -s -m:install -m:" Makefile
}

src_compile () {
	emake CC=$(tc-getCC) ARCH=$(tc-arch-kernel) CFLAGS="${CFLAGS}" || die "emake failed."
}

src_install () {
	dodir /usr/bin
	dodir /usr/share/man/man1
	emake BINDIR="${D}/usr/bin" MANDIR="${D}usr/share/man/man" install || die \
	"make install failed"
}
