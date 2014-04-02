# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/airpwn/airpwn-1.4-r2.ebuild,v 1.1 2014/04/02 20:37:01 zerochaos Exp $

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
		insinto /usr/share/${PN}
		rm -rf conf/CVS content/CVS
		sed -i "s#content/#/usr/share/${PN}/content/#" conf/*
		doins -r conf/
		doins -r content/
	fi
}
