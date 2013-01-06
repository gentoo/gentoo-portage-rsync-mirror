# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/gnu-netcat/gnu-netcat-0.7.1-r2.ebuild,v 1.2 2010/05/26 16:08:57 abcd Exp $

EAPI="3"

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="the GNU network swiss army knife"
HOMEPAGE="http://netcat.sourceforge.net/"
SRC_URI="mirror://sourceforge/netcat/netcat-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="nls debug"

DEPEND=""

S=${WORKDIR}/netcat-${PV}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-flagcount.patch
	epatch "${FILESDIR}"/${PN}-close.patch
}

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_enable debug)
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "emake install failed"
	rm "${ED}"usr/bin/nc
	dodoc AUTHORS ChangeLog NEWS README TODO
}
