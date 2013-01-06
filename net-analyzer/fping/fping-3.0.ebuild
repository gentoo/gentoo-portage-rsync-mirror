# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fping/fping-3.0.ebuild,v 1.7 2012/04/01 15:36:13 armin76 Exp $

EAPI="4"

inherit flag-o-matic

DESCRIPTION="A utility to ping multiple hosts at once"
HOMEPAGE="http://fping.org/"
SRC_URI="http://fping.org/dist/${P}.tar.gz"

LICENSE="fping"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE="ipv6"

src_prepare() {
	if use ipv6; then
		cp -a "${S}" "${S}-6"
	fi
}

src_configure() {
	econf
	if use ipv6; then
		cd "${S}-6"
		append-flags -DIPV6
		econf
	fi
}

src_compile() {
	emake
	if use ipv6; then
		cd "${S}-6"
		emake
	fi
}

src_install () {
	dosbin "${S}"/${PN}
	fperms 4555 /usr/sbin/fping #241930
	if use ipv6; then
		newsbin "${S}"-6/fping fping6
		fperms 4555 /usr/sbin/fping6
	fi
	doman fping.8
	dodoc ChangeLog README
}
