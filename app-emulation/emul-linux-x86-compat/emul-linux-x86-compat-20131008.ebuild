# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-compat/emul-linux-x86-compat-20131008.ebuild,v 1.2 2013/11/22 19:28:23 pacho Exp $

EAPI=5
inherit emul-linux-x86 eutils multilib

DESCRIPTION="32 bit lib-compat, and also libgcc_s and libstdc++ from gcc 3.3 and 3.4 for non-multilib systems"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64"
IUSE="multilib"

DEPEND=""
RDEPEND="multilib? ( sys-libs/libstdc++-v3 )"

src_prepare() {
	emul-linux-x86_src_prepare
	if has_multilib_profile ; then
		rm -rf "${S}/usr/lib32/libstdc++.so.5.0.7" \
			"${S}/usr/lib32/libstdc++.so.5" || die
	fi
}

src_install() {
	emul-linux-x86_src_install
	doenvd "${FILESDIR}/99libstdc++32"
}
