# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/vacation/vacation-1.2.6.2.ebuild,v 1.5 2008/07/31 07:32:12 phosphan Exp $

DESCRIPTION="automatic mail answering program"
HOMEPAGE="http://vacation.sourceforge.net/"
SRC_URI="mirror://sourceforge/vacation/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 x86"
SLOT="0"
IUSE=""

RDEPEND="virtual/mta
	sys-libs/gdbm"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	!mail-mta/sendmail"

src_unpack () {
	unpack ${A}
	cd "${S}"
	mv vacation.man vacation.1
	sed -i -e 's: -m486::; s:CFLAGS.*= \(.*\):CFLAGS += \1:' Makefile
}

src_compile () {
	emake CFLAGS="${CFLAGS}" || die "emake failed."
}

src_install () {
	dobin vacation
	dodoc AUTHORS ChangeLog README README.smrsh
	doman vacation.1
}
