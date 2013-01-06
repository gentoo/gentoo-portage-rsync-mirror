# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/astmanproxy/astmanproxy-1.1.ebuild,v 1.6 2009/12/23 12:52:19 flameeyes Exp $

inherit eutils multilib

DESCRIPTION="Proxy for the Asterisk manager interface"
HOMEPAGE="http://www.popvox.com/astmanproxy/"
SRC_URI="http://www.popvox.com/${PN}/${P}-20050705-0643.tgz"

IUSE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	# small patch for cflags and path changes
	epatch "${FILESDIR}"/${P}-gentoo.diff

	# Fix multilib
	sed -i -e "s#/usr/lib/#/usr/$(get_libdir)/#" "${S}/Makefile" \
		|| die "multilib sed failed"
}

src_install() {
	# bug #298082
	emake -j1 DESTDIR="${D}" install || die

	dodoc README README.* VERSIONS astmanproxy.conf

	docinto samples
	dodoc samples/*

	# fix permissions on config file
	fperms 0640 /etc/astmanproxy.conf

	newinitd "${FILESDIR}"/astmanproxy.rc6 astmanproxy
}
