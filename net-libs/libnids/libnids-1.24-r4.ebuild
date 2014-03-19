# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnids/libnids-1.24-r4.ebuild,v 1.1 2014/03/19 15:30:47 jer Exp $

EAPI=5
inherit eutils toolchain-funcs

DESCRIPTION="an implementation of an E-component of Network Intrusion Detection System"
HOMEPAGE="http://libnids.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1.2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+glib +libnet static-libs"

DEPEND="
	net-libs/libpcap
	glib? ( dev-libs/glib )
	libnet? ( >=net-libs/libnet-1.1.0-r3 )
"
RDEPEND="
	${DEPEND}
	!net-libs/libnids:1.1
"

src_prepare() {
	epatch "${FILESDIR}/${P}-ldflags.patch"
	epatch "${FILESDIR}/${P}-static-libs.patch"
}

src_configure() {
	tc-export AR
	econf \
		--enable-shared \
		$(use_enable glib libglib) \
		$(use_enable libnet libnet)
}

src_compile() {
	emake shared $(usex static-libs static '')
}

src_install() {
	local tgt
	for tgt in _installshared $(usex static-libs _install ''); do
		emake install_prefix="${D}" ${tgt}
	done

	dodoc CHANGES CREDITS MISC README doc/*
}
