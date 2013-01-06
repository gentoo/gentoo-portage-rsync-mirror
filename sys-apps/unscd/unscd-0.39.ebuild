# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/unscd/unscd-0.39.ebuild,v 1.2 2010/02/15 23:41:31 vapier Exp $

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
	emake unscd || die
}

src_install() {
	newinitd "${FILESDIR}"/unscd.initd unscd || die
	dosbin unscd || die
}
