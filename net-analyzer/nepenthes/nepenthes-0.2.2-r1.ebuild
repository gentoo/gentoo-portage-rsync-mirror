# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nepenthes/nepenthes-0.2.2-r1.ebuild,v 1.1 2014/10/25 11:50:22 jer Exp $

EAPI=5
inherit autotools eutils user

DESCRIPTION="Nepenthes is a low interaction honeypot that captures worms by emulating known vulnerabilities"
HOMEPAGE="http://nepenthes.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="
	>=net-misc/curl-7.22.0
	dev-libs/libpcre
	net-libs/adns
	sys-apps/file
"
DEPEND="${RDEPEND}"

pkg_setup() {
	enewgroup nepenthes
	enewuser nepenthes -1 -1 /dev/null nepenthes
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-Werror.patch \
		"${FILESDIR}"/${P}-cachedir.patch \
		"${FILESDIR}"/${P}-curl_types_h.patch \
		"${FILESDIR}"/${P}-gcc4.patch \
		"${FILESDIR}"/${P}-gcc44.patch \
		"${FILESDIR}"/${P}-libdir.patch \
		"${FILESDIR}"/${P}-sysconfdir.patch

	eautoreconf
}

src_configure() {
	econf \
		--disable-static \
		--enable-capabilities \
		--localstatedir=/var/lib/nepenthes \
		--sysconfdir=/etc
}

src_install() {
	default

	dodoc doc/README.VFS AUTHORS
	dosbin nepenthes-core/src/nepenthes
	rm "${D}"/usr/bin/nepenthes
	rm "${D}"/usr/share/doc/README.VFS
	rm "${D}"/usr/share/doc/logo-shaded.svg

	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	newconfd "${FILESDIR}/${PN}.confd" "${PN}"

	diropts -m 755 -o nepenthes -g nepenthes
	keepdir /var/log/nepenthes
	keepdir /var/lib/nepenthes
	keepdir /var/lib/nepenthes/binaries
	keepdir /var/lib/nepenthes/hexdumps
	keepdir /var/lib/nepenthes/cache
	keepdir /var/lib/nepenthes/cache/geolocation

	prune_libtool_files
}
