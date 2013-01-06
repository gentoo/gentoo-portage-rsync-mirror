# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fprobe/fprobe-1.1-r1.ebuild,v 1.2 2008/03/17 17:18:41 mr_bones_ Exp $

inherit eutils

DESCRIPTION="A libpcap-based tool to collect network traffic data and emit it as NetFlow flows"
HOMEPAGE="http://fprobe.sourceforge.net"
LICENSE="GPL-2"

SRC_URI="mirror://sourceforge/fprobe/${P}.tar.bz2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="debug messages"

DEPEND="net-libs/libpcap"

src_unpack() {
	unpack ${A}
	# The pidfile should be created by the parent process, before the
	# setuid/chroot # is executed.
	epatch "${FILESDIR}"/fprobe-1.1-pidfile-sanity.patch
	# This seems to fail, uncertain why.
	epatch "${FILESDIR}"/fprobe-1.1-setgroups.patch
}

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable messages) \
		|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"

	dodoc AUTHORS NEWS README TODO
	docinto contrib
	dodoc contrib/tg.sh

	newinitd "${FILESDIR}"/init.d-fprobe fprobe
	newconfd "${FILESDIR}"/conf.d-fprobe fprobe
}
