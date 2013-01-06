# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dibbler/dibbler-0.7.3.ebuild,v 1.4 2011/09/21 00:03:26 jer Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Portable DHCPv6 implementation (server, client and relay)"
HOMEPAGE="http://klub.com.pl/dhcpv6/"

SRC_URI="http://klub.com.pl/dhcpv6/dibbler/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~mips x86"
IUSE="doc"
DEPEND=""
RDEPEND=""

DIBBLER_DOCDIR=${S}/doc

src_prepare() {
	sed -i \
		-e "s#CC           ?= gcc#CC           ?= $(tc-getCC)#g" \
		-e "s#CXX          ?= g++#CXX          ?= $(tc-getCXX)#g" \
		Makefile.inc || die "Patching Makefile.inc failed"
}

src_compile() {
	emake -j1 || die "Compilation failed"
}

src_install() {
	dosbin dibbler-server
	dosbin dibbler-client
	dosbin dibbler-relay
	doman doc/man/dibbler-server.8 doc/man/dibbler-client.8 \
		doc/man/dibbler-relay.8
	dodoc CHANGELOG RELNOTES

	insinto /etc/dibbler
	doins *.conf
	dodir /var/lib/dibbler

	use doc && dodoc ${DIBBLER_DOCDIR}/dibbler-user.pdf \
			${DIBBLER_DOCDIR}/dibbler-devel.pdf

	insinto /etc/init.d
	doins "${FILESDIR}/dibbler-server" "${FILESDIR}/dibbler-client" \
		"${FILESDIR}/dibbler-relay"
	fperms 755 /etc/init.d/dibbler-server
	fperms 755 /etc/init.d/dibbler-client
	fperms 755 /etc/init.d/dibbler-relay
}

pkg_postinst() {
	einfo "Make sure that you modify client.conf, server.conf and/or relay.conf "
	einfo "to suit your needs. They are stored in /etc/dibbler."
}
