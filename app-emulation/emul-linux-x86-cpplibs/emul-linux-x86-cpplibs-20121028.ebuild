# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-cpplibs/emul-linux-x86-cpplibs-20121028.ebuild,v 1.2 2012/11/25 07:22:01 pacho Exp $

EAPI="4"
inherit emul-linux-x86

LICENSE="Boost-1.0 LGPL-2.1"
KEYWORDS="-* amd64"

DEPEND=""
RDEPEND="~app-emulation/emul-linux-x86-baselibs-${PV}"
