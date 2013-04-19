# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/airpwn/airpwn-1.4-r1.ebuild,v 1.1 2013/04/19 14:05:47 zerochaos Exp $

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

DEPEND=""
RDEPEND="net-wireless/lorcon-old
		 net-libs/libnet
		 dev-lang/python"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_configure() {
	append-ldflags $(no-as-needed)
	econf
	# this is a huge mess...
	sed -i "s/python2.4/python$(python_get_version)/g" conf.h || die "sed failed"
	sed -i "s|-lssl -lorcon -lpthread -lpcre -lpcap -lnet|-lssl -lorcon -lpthread -lpcre -lpcap -lnet -lpython$(python_get_version)|g" Makefile || die "sed failed"
}

src_install() {
	DESTDIR="${D}" emake install
	dodoc README
	if use examples; then
		docinto sample-configs
		dodoc conf/*
	fi
}
