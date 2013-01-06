# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/rainbowcrack/rainbowcrack-1.5.ebuild,v 1.2 2012/09/24 00:41:54 vapier Exp $

EAPI=4
inherit eutils

DESCRIPTION="Hash cracker that precomputes plaintext - ciphertext pairs in advance"
HOMEPAGE="http://project-rainbowcrack.com/"
SRC_URI="amd64? ( http://project-${PN}.com/${P}-linux64.zip )
	x86? ( http://project-${PN}.com/${P}-linux32.zip )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="app-arch/unzip"

RESTRICT="mirror" # http://bugs.gentoo.org/show_bug.cgi?id=312497#c8

RAINBOW_DESTDIR="opt/${PN}"

QA_FLAGS_IGNORED="${RAINBOW_DESTDIR}/.*"
QA_PRESTRIPPED="${RAINBOW_DESTDIR}/.*"

src_unpack() {
	unpack ${A}
	mv ${P}-linux* "${S}"
}

src_install() {
	local bin bins="rcrack rt2rtc rtc2rt rtgen rtsort"

	exeinto /${RAINBOW_DESTDIR}
	doexe alglib0.so ${bins}

	for bin in ${bins}; do
		make_wrapper ${bin} ./${bin} /${RAINBOW_DESTDIR} /${RAINBOW_DESTDIR}
	done

	insinto /${RAINBOW_DESTDIR}
	doins charset.txt

	dodoc readme.txt
}
