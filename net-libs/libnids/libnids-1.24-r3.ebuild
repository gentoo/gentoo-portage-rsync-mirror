# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnids/libnids-1.24-r3.ebuild,v 1.3 2013/06/27 18:08:55 ago Exp $

EAPI=5
inherit eutils toolchain-funcs

DESCRIPTION="an implementation of an E-component of Network Intrusion Detection System"
HOMEPAGE="http://libnids.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1.2"
KEYWORDS="amd64 ~ppc x86"
IUSE="+glib +libnet static-libs"

DEPEND="net-libs/libpcap
	glib? ( dev-libs/glib )
	libnet? ( >=net-libs/libnet-1.1.0-r3 )"
RDEPEND="${DEPEND}
	!net-libs/libnids:1.1"

src_prepare() {
	epatch "${FILESDIR}/${P}-ldflags.patch"
	sed -i src/Makefile.in -e 's|\tar |\t$(AR) |g' || die
}

src_configure() {
	tc-export AR
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
