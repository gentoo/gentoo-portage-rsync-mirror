# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/unscd/unscd-0.52-r1.ebuild,v 1.1 2014/10/09 13:43:41 jlec Exp $

EAPI=5

inherit toolchain-funcs

DESCRIPTION="simple & stable nscd replacement"
HOMEPAGE="http://busybox.net/~vda/unscd/README"
SRC_URI="http://busybox.net/~vda/unscd/nscd-${PV}.c"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-libs/glibc[nscd(+)]"
DEPEND="${RDEPEND}"

S=${WORKDIR}

src_unpack() {
	cp "${DISTDIR}"/nscd-${PV}.c ${PN}.c || die
}

src_compile() {
	tc-export CC
	emake unscd
}

src_install() {
	newinitd "${FILESDIR}"/unscd.initd-r1 unscd
	dosbin unscd
}
