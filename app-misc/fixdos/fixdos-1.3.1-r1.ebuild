# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/fixdos/fixdos-1.3.1-r1.ebuild,v 1.4 2013/05/24 19:45:30 ago Exp $

EAPI=5

MY_P="fixDos-${PV}"
inherit eutils toolchain-funcs

DESCRIPTION="Set of utilities such as crlf which converts files between UNIX and DOS newlines"
HOMEPAGE="http://e.co.za/marius/"
SRC_URI="http://e.co.za/marius/downloads/misc/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~x86 ~amd64-linux ~x86-linux"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo-makefile.diff
	epatch_user
	tc-export CC
}

src_install() {
	emake INSTALLDIR="${ED}/usr/bin" install
	dodoc Changelog README
}
