# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lib-compat/lib-compat-1.4.2.ebuild,v 1.5 2014/09/07 10:34:26 ulm Exp $

DESCRIPTION="Compatibility C++ and libc5 and libc6 libraries for programs new and old"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S=${WORKDIR}/${P}/${ARCH}

src_install() {
	if use x86 ; then
		into /
		dolib.so ld-linux.so.1*
		rm -f ld-linux.so.1*
	fi
	into /usr
	dolib.so *.so*
}
