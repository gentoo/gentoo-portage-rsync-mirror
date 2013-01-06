# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/portfwd/portfwd-0.28.ebuild,v 1.9 2010/10/28 10:15:42 ssuominen Exp $

WANT_AUTOCONF="2.5"
WANT_AUTOMAKE="1.4"
inherit autotools eutils

DESCRIPTION="Port Forwarding Daemon"
SRC_URI="mirror://sourceforge/${PN}/${P/_/}.tar.gz"
HOMEPAGE="http://portfwd.sourceforge.net"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ia64 ~ppc ~sparc x86"
IUSE=""

DEPEND=">=sys-apps/sed-4"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"/${P/_/}

	epatch "${FILESDIR}"/${P}-64bit.patch

	cd src
	sed -iorig \
		-e "s:^CFLAGS   =.*:CFLAGS   = @CFLAGS@ -Wall -DPORTFWD_CONF=\\\\\"\$(sysconfdir)/portfwd.cfg\\\\\":" \
		-e "s:^CXXFLAGS =.*:CPPFLAGS = @CXXFLAGS@ -Wall -DPORTFWD_CONF=\\\\\"\$(sysconfdir)/portfwd.cfg\\\\\":" \
		Makefile.am
	cd ../tools
	sed -iorig \
		-e "s:^CXXFLAGS =.*:CPPFLAGS = @CXXFLAGS@ -Wall -DPORTFWD_CONF=\\\\\"\$(sysconfdir)/portfwd.cfg\\\\\":" \
		Makefile.am
	cd ../getopt
	sed -iorig -e "s:$.CC.:\$(CC) @CFLAGS@:g" Makefile.am
	cd ../doc
	sed -iorig -e "s:/doc/portfwd:/share/doc/$P:" Makefile.am
	cd ..
	sed -iorig -e "s:/doc/portfwd:/share/doc/$P:" Makefile.am

	eautoreconf
}

src_compile() {
	cd "${WORKDIR}"/${P/_/}

	econf || die "econf failed"
	emake
}

src_install() {
	cd "${WORKDIR}"/${P/_/}

	einstall
	prepalldocs

	dodoc cfg/*

	newinitd "${FILESDIR}"/${PN}.init ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
}

pkg_postinst() {
	einfo "Many configuration file (/etc/portfwd.cfg) samples are available in /usr/share/doc/${P}"
}
