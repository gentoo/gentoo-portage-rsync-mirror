# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fping/fping-2.4_beta2_p161-r1.ebuild,v 1.11 2014/07/11 18:11:23 jer Exp $

EAPI="2"

inherit autotools eutils flag-o-matic

DESCRIPTION="A utility to ping multiple hosts at once"
SRC_URI="
	mirror://debian/pool/main/f/${PN}/${PN}_2.4b2-to-ipv6.orig.tar.gz
	mirror://debian/pool/main/f/${PN}/${PN}_2.4b2-to-ipv6-16.1.diff.gz
	"
HOMEPAGE="http://fping.sourceforge.net/ http://packages.qa.debian.org/f/fping.html"

SLOT="0"
LICENSE="fping"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE="ipv6"

S="${WORKDIR}/fping-2.4b2_to-ipv6"

src_prepare() {
	epatch \
		"${WORKDIR}"/fping_2.4b2-to-ipv6-16.1.diff \
		"${FILESDIR}"/${P}-min-time.patch
	eautoreconf

	if use ipv6; then
		cp -a "${S}" "${S}-6"
	fi
}

src_configure() {
	econf || die "econf failed"
	if use ipv6; then
		cd "${S}-6"
		append-flags -DIPV6
		econf || die "econf failed"
	fi
}

src_compile() {
	emake || die "econf failed"
	if use ipv6; then
		cd "${S}-6"
		emake || die "econf failed"
	fi
}

src_install () {
	dosbin "${S}"/${PN} || die "Failed to install fping."
	if use ipv6; then
		newsbin "${S}"-6/fping fping6 || die "Failed to install fping."
	fi
	fperms 4555 /usr/sbin/fping /usr/sbin/fping6 #241930
	doman fping.8
	dodoc ChangeLog README
}
