# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/easy-rsa/easy-rsa-2.2.0.ebuild,v 1.10 2014/10/04 14:11:22 blueness Exp $

EAPI=4

inherit eutils

DESCRIPTION="Small RSA key management package, based on OpenSSL"
HOMEPAGE="http://openvpn.net/"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
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
