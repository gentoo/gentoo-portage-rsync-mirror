# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tofrodos/tofrodos-1.7.8.ebuild,v 1.3 2009/12/28 12:24:11 jer Exp $

inherit eutils

DESCRIPTION="text file conversion utility that converts ASCII files between the
MSDOS format and the Unix format"
HOMEPAGE="http://tofrodos.sourceforge.net/"
SRC_URI="http://tofrodos.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}/src"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-CFLAGS.patch
}

src_compile() {
	emake DEBUG=1 CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die "Compile failed."
}

src_install() {
	dobin fromdos || die
	dosym fromdos /usr/bin/todos || die
	doman fromdos.1 || die
}
