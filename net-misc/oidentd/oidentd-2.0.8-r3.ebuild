# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/oidentd/oidentd-2.0.8-r3.ebuild,v 1.6 2010/06/22 14:39:46 jer Exp $

inherit eutils

DESCRIPTION="Another (RFC1413 compliant) ident daemon"
HOMEPAGE="http://dev.ojnk.net"
SRC_URI="mirror://sourceforge/ojnk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc s390 sh sparc x86 ~x86-fbsd"
IUSE="debug ipv6 masquerade"

RDEPEND=""
DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-masquerading.patch" \
		"${FILESDIR}/${P}-bind-to-ipv6-too.patch"
}

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable ipv6) \
		$(use_enable masquerade masq) \
		$(use_enable masquerade nat) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed!"

	dodoc AUTHORS ChangeLog README TODO NEWS \
		"${FILESDIR}"/${PN}_masq.conf "${FILESDIR}"/${PN}.conf

	newinitd "${FILESDIR}"/${PN}-2.0.7-init ${PN}
	newconfd "${FILESDIR}"/${PN}-2.0.7-confd ${PN}
}

pkg_postinst() {
	echo
	elog "Example configuration files are in /usr/share/doc/${PF}"
	echo
}
