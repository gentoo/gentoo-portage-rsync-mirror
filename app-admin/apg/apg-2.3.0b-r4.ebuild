# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/apg/apg-2.3.0b-r4.ebuild,v 1.6 2012/12/07 19:00:36 ulm Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Another Password Generator"
HOMEPAGE="http://www.adel.nursat.kz/apg/"
SRC_URI="http://www.adel.nursat.kz/apg/download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="cracklib"

DEPEND="cracklib? ( sys-libs/cracklib )"

src_unpack() {
	unpack ${A}
	chmod -R 0700 "${S}"
	cd "${S}"
	if use cracklib; then
		epatch "${FILESDIR}"/${P}-cracklib.patch
		epatch "${FILESDIR}"/${PN}-glibc-2.4.patch
	fi
	epatch "${FILESDIR}"/${P}-crypt_password.patch
}

src_compile() {
	sed -i 's,^#\(APG_CS_CLIBS += -lnsl\)$,\1,' Makefile
	[[ ${CHOST} == *-darwin* ]] && \
		sed -i 's,^APG_CLIBS += -lcrypt,APG_CLIBS += ,' Makefile

	emake standalone FLAGS="${CFLAGS}" CFLAGS="${CFLAGS}" CC="$(tc-getCC)" || die "compile problem"
	emake -C bfconvert FLAGS="${CFLAGS}" CC="$(tc-getCC)" || die "compile problem"
}

src_install() {
	dobin apg apgbfm bfconvert/bfconvert || die
	dodoc CHANGES INSTALL README THANKS TODO
	cd doc
	doman man/apg.1 man/apgbfm.1
	dodoc APG_TIPS pronun.txt rfc0972.txt rfc1750.txt
}
