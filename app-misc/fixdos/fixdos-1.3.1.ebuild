# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/fixdos/fixdos-1.3.1.ebuild,v 1.21 2011/01/04 18:04:30 jlec Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Set of utilities such as crlf which converts files between UNIX and DOS newlines"
HOMEPAGE="http://e.co.za/marius/"
SRC_URI="http://e.co.za/marius/downloads/misc/fixDos-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

S="${WORKDIR}"/fixDos-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo-makefile.diff
}

src_compile() {
	tc-export CC
	emake CC="$(tc-getCC)" || die
}

src_install() {
	make INSTALLDIR="${D}/usr/bin" install || die
}
