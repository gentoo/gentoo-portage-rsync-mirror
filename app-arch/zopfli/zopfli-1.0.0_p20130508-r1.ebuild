# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/zopfli/zopfli-1.0.0_p20130508-r1.ebuild,v 1.2 2013/11/06 18:43:39 pinkbyte Exp $

EAPI="5"

inherit toolchain-funcs

COMMIT="c54dc204ef4278f949a965dc90e693799b6aae41"
SONAME="1"

DESCRIPTION="Compression library programmed in C to perform very good, but slow, deflate or zlib compression."
HOMEPAGE="https://code.google.com/p/zopfli/"
SRC_URI="https://dev.gentoo.org/~tomwij/files/dist/${P}.zip"

LICENSE="Apache-2.0"
SLOT="0/${SONAME}"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/unzip"

S="${WORKDIR}/${PN}-${COMMIT:0:12}"

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
	dosym lib${PN}.so.* /usr/$(get_libdir)/lib${PN}.so.${SONAME}

	insinto /usr/include/${PN}/
	doins src/${PN}/*.h
}
