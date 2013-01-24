# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/easy-rsa/easy-rsa-2.2.0.ebuild,v 1.3 2013/01/24 15:44:56 jer Exp $

EAPI=4

inherit eutils multilib toolchain-funcs flag-o-matic

DESCRIPTION="Small RSA key management package, based on OpenSSL."
HOMEPAGE="http://openvpn.net/"
KEYWORDS="~amd64 ~hppa ~x86"
SRC_URI="http://swupdate.openvpn.net/community/releases/${P}_master.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/openssl-0.9.6"
RDEPEND="${DEPEND}
		!<net-misc/openvpn-2.3"

S="${WORKDIR}/${P}_master"

src_prepare() {
	epatch "${FILESDIR}/${PN}-2.0.0-pkcs11.patch"
}

src_configure() {
	econf --docdir="${EPREFIX}/usr/share/doc/${PF}"
}

src_install() {
	emake DESTDIR="${D}" install
	doenvd "${FILESDIR}/65easy-rsa" # config-protect easy-rsa
}
