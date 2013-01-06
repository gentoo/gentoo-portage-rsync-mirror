# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/sheerdns/sheerdns-1.0.1-r1.ebuild,v 1.1 2010/08/06 13:57:09 hwoarang Exp $

inherit eutils toolchain-funcs multilib

DESCRIPTION="Sheerdns is a small, simple, fast master only DNS server"
HOMEPAGE="http://threading.2038bug.com/sheerdns/"
SRC_URI="http://threading.2038bug.com/sheerdns/${P}.tar.gz
	http://dev.gentoo.org/~iggy/${P}-r0.patch"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND=""

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	epatch "${DISTDIR}"/${P}-r0.patch || die "failed to apply patch"
	cd "${S}"
	epatch "${FILESDIR}"/${P}-makefile.patch
	# Fix multilib support
	sed -i "/^CFLAGS/s:usr/lib:usr/$(get_libdir):" Makefile
}

src_compile() {
	emake CC=$(tc-getCC) || die
}

src_install() {
	dodoc ChangeLog
	doman sheerdns.8
	dosbin sheerdns sheerdnshash
}
