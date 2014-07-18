# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/udpcast/udpcast-20120424.ebuild,v 1.5 2014/07/18 21:39:32 jer Exp $

EAPI=5
inherit eutils

DESCRIPTION="Multicast file transfer tool"
HOMEPAGE="http://www.udpcast.linux.lu/"
SRC_URI="http://www.udpcast.linux.lu/download/${P}.tar.bz2"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="dev-lang/perl"

src_prepare() {
	epatch "${FILESDIR}"/${P}-fd_set.patch
	sed -i Makefile.in \
		-e '/^LDFLAGS +=-s/d' \
		-e '/^CFLAGS/s: -O6::g' \
		|| die
}

src_install() {
	default
	dodoc *.txt
}
