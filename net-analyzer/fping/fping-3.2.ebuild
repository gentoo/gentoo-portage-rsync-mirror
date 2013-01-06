# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fping/fping-3.2.ebuild,v 1.1 2012/05/29 10:33:11 radhermit Exp $

EAPI=4

inherit flag-o-matic

DESCRIPTION="A utility to ping multiple hosts at once"
HOMEPAGE="http://fping.org/"
SRC_URI="http://fping.org/dist/${P}.tar.gz"

LICENSE="fping"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE="ipv6"

src_prepare() {
	if use ipv6; then
		cp -a "${S}" "${S}-6"
	fi
}

src_configure() {
	default
	if use ipv6; then
		cd "${S}-6"
		append-cppflags -DIPV6
		econf
	fi
}

src_compile() {
	default
	if use ipv6; then
		cd "${S}-6"
		emake
	fi
}

src_install () {
	dosbin "${S}"/src/${PN}
	fperms 4555 /usr/sbin/fping #241930
	if use ipv6; then
		newsbin "${S}"-6/src/fping fping6
		fperms 4555 /usr/sbin/fping6
	fi
	doman doc/fping.8
	dodoc ChangeLog README
}
