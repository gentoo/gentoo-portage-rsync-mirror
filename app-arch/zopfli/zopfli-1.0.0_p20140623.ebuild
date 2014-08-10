# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/zopfli/zopfli-1.0.0_p20140623.ebuild,v 1.2 2014/08/10 01:43:12 patrick Exp $

EAPI="5"

inherit eutils toolchain-funcs vcs-snapshot

DESCRIPTION="Compression library programmed in C to perform very good, but slow, deflate or zlib compression"
HOMEPAGE="https://code.google.com/p/zopfli/"
SRC_URI="https://zopfli.googlecode.com/archive/b831d9813d44d85b4f1497be9cb877e4d5c4bbd7.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/1"
KEYWORDS="~amd64 ~x86"

src_prepare() {
	epatch_user
}

src_compile() {
	local target
	for target in lib${PN} ${PN} ${PN}png; do
		emake \
			CC="$(tc-getCC)" \
			CXX="$(tc-getCXX)" \
			CFLAGS="-W -Wall -Wextra -ansi -pedantic -lm ${CFLAGS}" \
			CXXFLAGS="-W -Wall -Wextra -ansi -pedantic ${CXXFLAGS}" \
			${target}
	done
}

src_install() {
	dobin ${PN} ${PN}png

	dodoc CONTRIBUTORS README README.${PN}png

	dolib lib${PN}.so.*
	dosym lib${PN}.so.* /usr/$(get_libdir)/lib${PN}.so
	dosym lib${PN}.so.* /usr/$(get_libdir)/lib${PN}.so.1

	insinto /usr/include/${PN}/
	doins src/${PN}/*.h
}
