# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/msp430-gcc/msp430-gcc-4.6.3_p20120406.ebuild,v 1.1 2012/04/28 10:07:52 radhermit Exp $

EAPI="4"

PATCH_VER="1.0"
BRANCH_UPDATE=""

inherit toolchain

DESCRIPTION="The GNU Compiler Collection for MSP430 microcontrollers"
LICENSE="GPL-3 LGPL-3 || ( GPL-3 libgcc libstdc++ gcc-runtime-library-exception-3.1 ) FDL-1.2"
KEYWORDS="~amd64 ~x86"
SRC_URI="${SRC_URI} http://dev.gentoo.org/~radhermit/distfiles/${P}.patch.bz2"

RDEPEND=""
DEPEND="${RDEPEND}
	elibc_glibc? ( >=sys-libs/glibc-2.8 )
	${CATEGORY}/msp430-binutils"

pkg_pretend() {
	is_crosscompile || die "Only cross-compile builds are supported"
}

src_prepare() {
	epatch "${DISTDIR}"/${P}.patch.bz2
}
