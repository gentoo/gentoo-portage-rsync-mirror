# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-jna/emul-linux-x86-jna-20140508-r1.ebuild,v 1.1 2014/11/12 21:47:58 axs Exp $

EAPI=5
inherit emul-linux-x86

LICENSE="LGPL-2.1"
KEYWORDS="-* ~amd64"

DEPEND=""
RDEPEND="|| (
	>=virtual/libffi-3.0.13-r1[abi_x86_32(-)]
	~app-emulation/emul-linux-x86-baselibs-${PV}[-abi_x86_32(-)]
)"
