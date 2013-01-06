# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/gnu-netcat/gnu-netcat-0.7.1-r1.ebuild,v 1.7 2010/08/12 19:58:16 josejx Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="the GNU network swiss army knife"
HOMEPAGE="http://netcat.sourceforge.net/"
SRC_URI="mirror://sourceforge/netcat/netcat-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ppc sparc x86 ~x86-fbsd"
IUSE="nls debug"

DEPEND=""

S=${WORKDIR}/netcat-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-flagcount.patch
}

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable debug) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "emake install failed"
	rm "${D}"/usr/bin/nc
	dodoc AUTHORS ChangeLog NEWS README TODO
}
