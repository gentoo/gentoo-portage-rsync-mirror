# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-it/fortune-mod-it-1.99.ebuild,v 1.10 2010/12/12 17:06:40 grobian Exp $

DESCRIPTION="Database of the Italian cookies for the fortune program"
HOMEPAGE="http://www.fortune-it.net/"
SRC_URI="http://www.fortune-it.net/download/fortune-it-${PVR}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="offensive"

DEPEND="games-misc/fortune-mod"

S=${WORKDIR}/fortune-it-${PVR}

src_unpack() {
	unpack ${A}
	use offensive || rm -f "${S}"/testi/*-o
}

src_compile() {
	local f
	for f in testi/* ; do
		strfile -s ${f} || die "strfile ${f} failed"
	done
}

src_install() {
	insinto /usr/share/fortune
	doins testi/* || die "cp failed"
	dodoc README
}
