# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libeXosip/libeXosip-3.3.0.ebuild,v 1.6 2010/07/18 12:32:40 nixnut Exp $

EAPI="2"

inherit eutils autotools

MY_PV=${PV%.?}-${PV##*.}
MY_PV=${PV}
MY_P=${PN}2-${MY_PV}
DESCRIPTION="library that hides the complexity of using the SIP protocol for multimedia session establishement"
HOMEPAGE="http://savannah.nongnu.org/projects/exosip/"
SRC_URI="http://download.savannah.nongnu.org/releases/exosip/${MY_P}.tar.gz"

KEYWORDS="amd64 ppc x86 ~ppc-macos ~x86-macos"
SLOT="0"
LICENSE="GPL-2"
IUSE="+srv ssl"

DEPEND=">=net-libs/libosip-3.2.0
	ssl? ( dev-libs/openssl )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}/${P}-automagic-openssl.patch"
	AT_M4DIR="scripts" eautoreconf
}

src_configure() {
	econf \
		--enable-mt \
		$(use_enable ssl openssl) \
		$(use_enable srv srvrec)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
