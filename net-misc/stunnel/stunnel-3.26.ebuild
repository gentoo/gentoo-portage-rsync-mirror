# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/stunnel/stunnel-3.26.ebuild,v 1.23 2013/08/02 15:17:48 ulm Exp $

EAPI=5

inherit eutils

DESCRIPTION="TLS/SSL - Port Wrapper"
HOMEPAGE="http://www.stunnel.org/"
SRC_URI="http://www.stunnel.org/download/stunnel/src/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE="selinux"

DEPEND=">=dev-libs/openssl-0.9.6j"
RDEPEND="${DEPEND}
	selinux? ( sec-policy/selinux-stunnel )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.diff
}

src_install() {
	dosbin stunnel
	dolib.so stunnel.so
	dodoc FAQ README HISTORY BUGS PORTS TODO
	doman stunnel.8
}
