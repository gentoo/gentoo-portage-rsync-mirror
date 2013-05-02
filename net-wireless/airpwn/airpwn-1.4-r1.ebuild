# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/airpwn/airpwn-1.4-r1.ebuild,v 1.2 2013/05/02 06:29:36 zerochaos Exp $

EAPI="5"

PYTHON_DEPEND="2:2.4"

inherit python flag-o-matic

DESCRIPTION="a tool for generic packet injection on 802.11"
HOMEPAGE="http://airpwn.sf.net"
SRC_URI="mirror://sourceforge/airpwn/$P.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+examples"

DEPEND="dev-libs/libpcre
	dev-libs/openssl
	net-libs/libnet
	net-libs/libpcap
	net-wireless/lorcon-old"
RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_configure() {
	econf
	sed -i "s/python2.4/python$(python_get_version)/g" conf.h
	sed -i "s|-lorcon -lpthread -lpcre -lpcap -lnet|-lorcon -lpthread -lpcre -lpcap -lnet -lcrypto -lpython$(python_get_version)|g" Makefile
}

src_install() {
	DESTDIR="${D}" emake install
	dodoc README
	if use examples; then
		docinto sample-configs
		rm -rf conf/CVS
		dodoc conf/*
	fi
}
