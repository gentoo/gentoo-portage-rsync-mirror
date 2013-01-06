# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnids/libnids-1.24-r2.ebuild,v 1.5 2012/06/09 06:28:15 jdhore Exp $

EAPI="4"

inherit eutils

DESCRIPTION="an implementation of an E-component of Network Intrusion Detection System"
HOMEPAGE="http://libnids.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1.2"
KEYWORDS="amd64 ppc x86"
IUSE="+glib +libnet static-libs"

DEPEND="net-libs/libpcap
	glib? ( dev-libs/glib )
	libnet? ( >=net-libs/libnet-1.1.0-r3 )"
RDEPEND="${DEPEND}
	!net-libs/libnids:1.1"

src_prepare() {
	epatch "${FILESDIR}/${P}-ldflags.patch"
}

src_configure() {
	local myconf="--enable-shared"
	use glib || myconf="${myconf} --disable-libglib"
	use libnet || myconf="${myconf} --disable-libnet"
	econf ${myconf}
}

src_install() {
	emake install_prefix="${D}" install
	use static-libs || rm -f "${D}"/usr/lib*/libnids.a
	dodoc CHANGES CREDITS MISC README doc/*
}
