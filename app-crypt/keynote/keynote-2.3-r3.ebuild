# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/keynote/keynote-2.3-r3.ebuild,v 1.3 2012/12/31 23:22:22 jdhore Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="The KeyNote Trust-Management System"
HOMEPAGE="http://www1.cs.columbia.edu/~angelos/keynote.html"
SRC_URI="http://www1.cs.columbia.edu/~angelos/Code/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="ssl"

RDEPEND="ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	virtual/yacc"

pkg_setup() {
	tc-export AR CC RANLIB
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-qa.patch
	epatch "${FILESDIR}"/${P}-parallel-build.patch
}

src_compile() {
	if use ssl; then
		emake
	else
		emake nocrypto
	fi
}

src_install() {
	dobin keynote

	dolib.a libkeynote.a

	insinto /usr/include
	doins keynote.h

	doman man/keynote.[1345]
	dodoc README HOWTO.add.crypto TODO
}
