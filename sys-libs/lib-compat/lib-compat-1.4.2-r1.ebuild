# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lib-compat/lib-compat-1.4.2-r1.ebuild,v 1.1 2014/06/26 08:33:47 mgorny Exp $

EAPI=5

DESCRIPTION="Compatibility C++ and libc5 and libc6 libraries for very old programs"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~x86"
IUSE=""

RDEPEND="!<=app-emulation/emul-linux-x86-compat-20140508"

src_install() {
	if use alpha ; then
		cd alpha || die
	else
		cd x86 || die
		ABI=x86

		into /
		dolib.so ld-linux.so.1*
		rm -f ld-linux.so.1*
	fi
	into /usr
	dolib.so *.so*
}
