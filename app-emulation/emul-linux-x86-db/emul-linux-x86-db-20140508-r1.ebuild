# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-db/emul-linux-x86-db-20140508-r1.ebuild,v 1.1 2014/05/25 16:43:55 mgorny Exp $

EAPI=5
inherit emul-linux-x86

LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="-* ~amd64"

IUSE="abi_x86_32"

DEPEND=""
RDEPEND="~app-emulation/emul-linux-x86-baselibs-${PV}
	abi_x86_32? (
		>=dev-db/unixODBC-2.3.2[abi_x86_32(-)]
	)"

src_prepare() {
	emul-linux-x86_src_prepare

	# Remove migrated stuff.
	use abi_x86_32 && rm -f $(sed "${FILESDIR}/remove-native-${PVR}" -e '/^#/d')
}
