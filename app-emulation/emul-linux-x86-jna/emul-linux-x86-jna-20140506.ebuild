# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-jna/emul-linux-x86-jna-20140506.ebuild,v 1.1 2014/05/06 20:53:33 pacho Exp $

EAPI=5
inherit emul-linux-x86

LICENSE="LGPL-2.1"
KEYWORDS="-* ~amd64"

DEPEND=""
RDEPEND="~app-emulation/emul-linux-x86-baselibs-${PV}"
