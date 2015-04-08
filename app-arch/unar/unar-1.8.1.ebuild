# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unar/unar-1.8.1.ebuild,v 1.1 2014/12/25 13:02:05 hanno Exp $

EAPI=5

inherit toolchain-funcs

DESCRIPTION="unpacker for various archiving formats, e.g. rar v3"
HOMEPAGE="http://unarchiver.c3.cx/"
SRC_URI="http://theunarchiver.googlecode.com/files/${PN}${PV}_src.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="gnustep-base/gnustep-base
	>=gnustep-base/gnustep-make-2.6.0[native-exceptions]
	dev-libs/icu:="
DEPEND="${RDEPEND}
	sys-devel/gcc[objc]"

S="${WORKDIR}/The Unarchiver/XADMaster"

src_compile() {
	emake -f Makefile.linux \
		AR="$(tc-getAR)" \
		CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)" \
		OBJCC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		CXXFLAGS="${CXXFLAGS}" \
		OBJCFLAGS="${CFLAGS}" \
		LD="$(tc-getCXX)" \
		LDFLAGS="-Wl,--whole-archive -fexceptions -fgnu-runtime ${LDFLAGS}"
}

src_install() {
	dobin {ls,un}ar
	doman ../Extra/{ls,un}ar.1
}
