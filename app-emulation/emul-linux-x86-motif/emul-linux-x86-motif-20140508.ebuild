# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-motif/emul-linux-x86-motif-20140508.ebuild,v 1.3 2014/06/26 09:23:41 pacho Exp $

EAPI=5

inherit emul-linux-x86

SRC_URI="!abi_x86_32? ( ${SRC_URI} )"
LICENSE="!abi_x86_32? ( LGPL-2+ MIT MOTIF ) abi_x86_32? ( metapackage )"
KEYWORDS="-* amd64"
IUSE="abi_x86_32"

RDEPEND="!<app-emulation/emul-linux-x86-xlibs-20110129
	!abi_x86_32? (
		!x11-libs/motif[abi_x86_32(-)]
		~app-emulation/emul-linux-x86-baselibs-${PV}
		~app-emulation/emul-linux-x86-xlibs-${PV}
	)
	abi_x86_32? (
		>=x11-libs/motif-2.3.4-r1:0[abi_x86_32(-)]
		>=x11-libs/motif-2.2.3-r12:2.2[abi_x86_32(-)]
	)"

src_install() {
	use abi_x86_32 || emul-linux-x86_src_install
}
