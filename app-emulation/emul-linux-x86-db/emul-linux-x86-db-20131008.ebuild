# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-db/emul-linux-x86-db-20131008.ebuild,v 1.1 2013/10/08 20:57:18 pacho Exp $

EAPI=5
inherit emul-linux-x86

LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="-* ~amd64"

DEPEND=""
RDEPEND="~app-emulation/emul-linux-x86-baselibs-${PV}"
