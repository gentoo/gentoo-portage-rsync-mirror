# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/openssl-tpm-engine/openssl-tpm-engine-0.4.1.ebuild,v 1.2 2009/05/10 23:13:30 robbat2 Exp $

MY_P="${P/-tpm-/_tpm_}"

DESCRIPTION="This provides a OpenSSL engine that uses private keys stored in TPM hardware"
HOMEPAGE="http://trousers.sourceforge.net"
SRC_URI="mirror://sourceforge/trousers/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND=">=dev-libs/openssl-0.9.8
	>=app-crypt/trousers-0.2.8"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf --with-openssl=/usr || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc openssl.cnf.sample README
}
