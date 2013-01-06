# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/af_alg/af_alg-0_pre20120229.ebuild,v 1.1 2012/11/13 00:47:18 robbat2 Exp $

EAPI=5

inherit eutils toolchain-funcs

COMMIT_ID=7b13512edbd77c35d20edb4e53d5d83eeaf05d52

DESCRIPTION="AF_ALG for OpenSSL"
HOMEPAGE="http://carnivore.it/2011/04/23/openssl_-_af_alg"

MY_P="$PN-${COMMIT_ID}"
SRC_URI="http://src.carnivore.it/users/common/af_alg/snapshot/${MY_P}.tar.gz"

LICENSE="openssl"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_compile() {
  $(tc-getCC) ${CFLAGS} -Wall -fPIC -c -o e_af_alg.o e_af_alg.c
  $(tc-getCC) ${LDFLAGS} -shared -Wl,-soname,libaf_alg.so -lcrypto -o libaf_alg.so e_af_alg.o
}

src_install() {
	exeinto /usr/$(get_libdir)/engines
	doexe libaf_alg.so
	dodoc README
}
