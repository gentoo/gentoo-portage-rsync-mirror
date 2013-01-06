# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/unscd/unscd-0.49.ebuild,v 1.2 2012/08/10 15:26:34 vapier Exp $

inherit toolchain-funcs

DESCRIPTION="simple & stable nscd replacement"
HOMEPAGE="http://busybox.net/~vda/unscd/README"
SRC_URI="http://busybox.net/~vda/unscd/nscd-${PV}.c"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S=${WORKDIR}

src_unpack() {
	cp "${DISTDIR}"/nscd-${PV}.c unscd.c || die
}

src_compile() {
	tc-export CC
	emake unscd || die
}

src_install() {
	newinitd "${FILESDIR}"/unscd.initd unscd || die
	dosbin unscd || die
}
