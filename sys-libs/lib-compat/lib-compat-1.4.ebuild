# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lib-compat/lib-compat-1.4.ebuild,v 1.12 2012/05/20 12:22:03 ferringb Exp $

DESCRIPTION="Compatibility C++ and libc5 and libc6 libraries for programs new and old"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha x86"
IUSE="sdl"

RDEPEND="sys-libs/glibc
	sdl? ( media-libs/libsdl )"

S=${WORKDIR}/${P}/${ARCH}

src_unpack() {
	unpack ${A}

	cd "${S}"
	# Rather install this with the proper filename
	mv -f libstdc++-libc6.2-2.so.3 libstdc++-3-libc6.2-2-2.10.0.so
	# libstdc++-2-libc6.1-1-2.9.0.so provides this one ...
	rm -f libstdc++-libc6.1-1.so.2
	# No package installs this one, so no need for the .dummy
	mv -f libstdc++.so.2.9.dummy libstdc++.so.2.9.0
	# dont install if they dont want sdl
	rm -f libsmpeg-0.4.so.0.dummy
}

src_install() {
	if use x86 ; then
		into /
		dolib.so ld-linux.so.1*
		rm -f ld-linux.so.1*
	fi
	into /usr
	dolib.so *.so*
}
