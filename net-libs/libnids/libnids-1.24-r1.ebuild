# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnids/libnids-1.24-r1.ebuild,v 1.7 2012/03/10 16:34:03 ranger Exp $

EAPI="2"

inherit eutils

DESCRIPTION="an implementation of an E-component of Network Intrusion Detection System"
HOMEPAGE="http://libnids.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1.2"
KEYWORDS="amd64 ppc x86"
IUSE="+glib +libnet"

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
	econf ${myconf} || die "econf failed"
}

src_install() {
	emake install_prefix="${D}" install || die "emake install failed"
	dodoc CHANGES CREDITS MISC README
	dodoc doc/*
}
