# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/msn-pecan/msn-pecan-0.1.4.ebuild,v 1.1 2012/10/15 09:54:42 voyageur Exp $

EAPI=4

inherit eutils toolchain-funcs multilib

DESCRIPTION="Alternative MSN protocol plugin for libpurple"
HOMEPAGE="http://code.google.com/p/msn-pecan/"

SRC_URI="http://msn-pecan.googlecode.com/files/${P/_/-}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-im/pidgin"
DEPEND="virtual/pkgconfig
	${RDEPEND}"

S=${WORKDIR}/${P/_/-}

src_prepare() {
	sed -e "/^LDFLAGS/{s/$/ ${LDFLAGS}/;}" \
		-e "/^CFLAGS/{s/$/ ${CFLAGS}/;}" -i Makefile \
		|| die "Flags sed failed"
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc ChangeLog README TODO
}

pkg_postinst() {
	elog "Select the 'WLM' protocol to use this plugin"
	einfo
	elog "For more information (how to change personal message, add"
	elog "missing emoticons, ...), please read:"
	elog "http://code.google.com/p/msn-pecan/wiki/FAQ"
}
