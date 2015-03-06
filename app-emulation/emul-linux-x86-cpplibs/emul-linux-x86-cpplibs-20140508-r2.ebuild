# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-cpplibs/emul-linux-x86-cpplibs-20140508-r2.ebuild,v 1.2 2015/03/05 23:33:11 tetromino Exp $

EAPI=5
inherit emul-linux-x86

LICENSE="Boost-1.0 LGPL-2.1"
KEYWORDS="-* ~amd64"

IUSE="abi_x86_32"

DEPEND=""
RDEPEND="!abi_x86_32? (
		~app-emulation/emul-linux-x86-baselibs-${PV}
		!>=dev-libs/boost-1.55.0-r2[abi_x86_32(-)]
		!>=dev-libs/libsigc++-2.4.0-r1[abi_x86_32(-)]
	)
	abi_x86_32? (
		>=dev-libs/boost-1.55.0-r2[abi_x86_32(-)]
		>=dev-libs/libsigc++-2.4.0-r1[abi_x86_32(-)]
	)"

src_prepare() {
	emul-linux-x86_src_prepare

	# Remove migrated stuff.
	use abi_x86_32 && rm -f $(cat "${FILESDIR}/remove-native-${PVR}")
}

src_install() {
	# Don't die if all files were migrated
	if ! use abi_x86_32 || [[ $(find "${S}" . -type f | wc -l) != "0" ]]; then
		emul-linux-x86_src_install
	fi
}
