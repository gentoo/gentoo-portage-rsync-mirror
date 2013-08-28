# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/higan-ananke/higan-ananke-092.ebuild,v 1.3 2013/08/28 11:13:56 ago Exp $

EAPI=5

inherit eutils multilib toolchain-funcs

MY_P=higan_v${PV}-source

DESCRIPTION="A higan helper library needed for extra rom load options"
HOMEPAGE="http://byuu.org/higan/"
SRC_URI="http://higan.googlecode.com/files/${MY_P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S=${WORKDIR}/${MY_P}/ananke

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-makefile.patch \
		"${FILESDIR}"/${P}-bps-path-fix.patch
}

src_compile() {
	emake \
		platform="x" \
		compiler="$(tc-getCXX)"
}

src_install() {
	newlib.so libananke.so libananke.so.1
	dosym libananke.so.1 /usr/$(get_libdir)/libananke.so
}
