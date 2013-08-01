# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-motif/emul-linux-x86-motif-20130224.ebuild,v 1.4 2013/08/01 20:20:48 ulm Exp $

EAPI=5
inherit emul-linux-x86

LICENSE="LGPL-2+ MIT MOTIF"

KEYWORDS="-* amd64"

DEPEND=""
RDEPEND="~app-emulation/emul-linux-x86-baselibs-${PV}
	~app-emulation/emul-linux-x86-xlibs-${PV}
	!<app-emulation/emul-linux-x86-xlibs-20110129
	!x11-libs/motif[abi_x86_32]"
