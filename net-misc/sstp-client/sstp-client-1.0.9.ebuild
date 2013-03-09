# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sstp-client/sstp-client-1.0.9.ebuild,v 1.1 2013/03/09 20:35:49 maksbotan Exp $

EAPI=5

inherit eutils linux-info user

DESCRIPTION="A client implementation of Secure Socket Tunneling Protocol (SSTP)"
HOMEPAGE="http://sstp-client.sourceforge.net/"
SRC_URI="mirror://sourceforge/sstp-client/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static"

DEPEND=">=dev-libs/libevent-2.0.10
	dev-libs/openssl:0
	net-dialup/ppp"
RDEPEND="${DEPEND}"

CONFIG_CHECK="~NETFILTER_NETLINK"
DOCS=( AUTHORS ChangeLog DEVELOPERS INSTALL NEWS README TODO USING )

pkg_setup() {
	enewgroup sstpc
	enewuser sstpc -1 -1 -1 sstpc
}

src_prepare() {
	# set proper examples dir, --docdir overriding is src_configure does not work
	sed -i -e "/^docdir/s:@PACKAGE@:${PF}/examples:" Makefile.in || die 'sed on Makefile.in failed'
}

src_configure() {
	econf \
		--enable-ppp-plugin \
		--enable-group=sstpc \
		--enable-user=sstpc \
		$(use_enable static)
}

src_install() {
	default
	prune_libtool_files --modules
}

pkg_postinst() {
	ewarn "If sstp clients fails to work after net-dialup/ppp update,"
	ewarn "please rebuild it before filing bugs."
}
